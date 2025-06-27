import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:flutter/services.dart';

class AddressController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestAddress = StatusRequest.none;
  final BuildContext context;
  final bool isHome;

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  //AddCityData addCityData = AddCityData(Get.find());
  late Position position;
  // UserModel? user;
  String message = '';
  StatusRequest statusRequest1 = StatusRequest.loading;
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  bool isfoundProfile = ConstData.user?.user.profile != null;
  double? latitude;
  double? longitude;
  CameraPosition? kGooglePlex;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();
  String? currentCity;

  AddressController(this.context, {required this.isHome});

  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    // update();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false;
        update();
        Get.snackbar("تنبيه", "يرجى السماح بالوصول إلى الموقع");
        return;
      }
    }

    try {
      position = await Geolocator.getCurrentPosition();
      print("========== latitude ==========${position.latitude}");
      print("========== longitude ==========${position.longitude}");
      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      currentCity = placemarks[0].administrativeArea!;

      print("========== currentCity ==========$currentCity");
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Alert", "The Map does not support your location");
      currentCity = "undefined";
    }
    await addMarkers(LatLng(position.latitude, position.longitude));
    update();
  }

  onPressedAddLocationFromMap() {
    if (latitude == null || longitude == null) {
      Get.defaultDialog(
        title: 'Warning',
        middleText: "Please wait until map loaded",
      );
    } else {
      /* Get.toNamed(AppRoutes.addressadd,
          arguments: {'latitude': latitude, 'longitude': longitude}); */
    }
  }

  onRefresh() {
    //  onPressedUseCurrentLocation();
    update();
  }

  onTapSkip() {
    Get.offNamed(AppRoutes.homepage);
  }

  validate(value) {
    if (value == null || value.isEmpty) {
      return "يجب ان تدخل عنوانك";
    }
    return null;
  }

  @override
  void onInit() {
    print(kGooglePlex);
    getCurrentLocation();
    super.onInit();
  }

  Future<void> updateAddress() async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('خطأ', 'من فضلك أدخل عنوانك');
      addressController.clear();
      return;
    }

    statusRequestAddress = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.postAddress(
      ConstData.user!.user.type == 'service_provider'
          ? ApiLinks.updateProfileService
          : ApiLinks.updateProfileProduct,
      {
        'address': addressController.text,
        'lang': '$longitude',
        'lat': '$latitude',
      },
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequestAddress = StatusRequest.failure;

        if (failure == StatusRequest.offlineFailure) {
          message = 'تحقق من الاتصال بالإنترنت';
        } else {
          message = 'حدث خطأ أثناء التحديث';
        }

        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) async {
        if (data != null && data is Map<String, dynamic>) {
          statusRequestAddress = StatusRequest.success;

          // عرض رسالة نجاح
          Get.snackbar(
            'تم بنجاح',
            'تم تحديث عنوانك بنجاح',
            snackPosition: SnackPosition.TOP,
            // backgroundColor: Colors.green,
            //  colorText: Colors.white,
          );

          addressController.clear();

          await Future.delayed(Duration(milliseconds: 700));

          // الانتقال أو الرجوع
          if (isHome) {
            print('➡️ trying to go back or navigate');
            //  BuildContext context=BuildContext();
            Navigator.pop(context);
            /*   Get.off(
            BottomNavBarScreen(
              prov: ConstData.producter ? 'product_provider' : 'service_provider',
            ),
          ); */
          } else {
            Get.offAll(
              BottomNavBarScreen(
                prov:
                    ConstData.producter
                        ? 'product_provider'
                        : 'service_provider',
              ),
            );
          }
        } else {
          statusRequestAddress = StatusRequest.failure;
          message = 'حدث خطأ أثناء حفظ البيانات';
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        }

        update();
        Get.back();
      },
    );
  }

  Future<void> storeProfile() async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('تنبيه', 'يرجى ملء الحقول بشكل صحيح');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse(
        ConstData.user!.user.type == 'service_provider'
            ? ApiLinks.updateProfileService
            : ApiLinks.updateProfileProduct,
      );
      var request = http.MultipartRequest("POST", uri);

      // Headers with token
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['address'] = addressController.text;
      request.fields['lang'] = '$longitude';
      request.fields['lat'] = '$latitude';
      request.fields['national_id'] = '${ConstData.user!.user.nationalId}';

      // Attach all selected images

      final byteData = await rootBundle.load('assets/images/user.png');
      final Uint8List imageBytes = byteData.buffer.asUint8List();

      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'user.png',
        contentType: MediaType('image', 'png'),
      );

      request.files.add(multipartFile);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeResponse = json.decode(responseData);
        //   String address = decodeResponse['daa']['address'];

        /*    await MyServices.saveValue(SharedPreferencesKey.address, address);

        await MyServices().setConstAddress(); */

        //  HomeController homeController = Get.find<HomeController>();
        CustomSnackBar('تم رفع المعلومات بنجاح', true);

        statusRequest = StatusRequest.success;
        Get.off(
          BottomNavBarScreen(
            prov:
                ConstData.user!.user.type != 'service_provider'
                    ? 'product_provider'
                    : 'service_provider',
          ),
        );
      } else {
        print(responseData);
        CustomSnackBar(
          'فشل في رفع المعلومات! رمز الحالة: ${response.statusCode}',
          false,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print("❌ خطأ: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء رفع المعومات',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    update();
  }

  @override
  void onClose() {
    addressController.clear();
    super.onClose();
  }
}
