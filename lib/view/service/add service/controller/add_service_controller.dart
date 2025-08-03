import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/category_model.dart';
import 'package:provider_mersal/view/home/home%20service/controller/home_services_controller.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class AddServiceController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController service_time = TextEditingController();
  RxBool isLoading = false.obs;
  bool isDescount = false;
  int? categoryId;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];
  List<File> selectedImages = [];
  String message = '';
  TextEditingController descount = TextEditingController();
  TextEditingController firstDateDiscount = TextEditingController();

  TextEditingController lastDateDiscount = TextEditingController();
  void setSelectedCategory(CategoryModel? category) {
    selectedCategory = category;
    for (var c in categories) {
      if (c.name == selectedCategory) {
        categoryId == c.id;
        break;
      }
    }

    update();
  }

  onInit() {
    super.onInit();
    getCategories();
    price.addListener(_updateDiscountedPrice);
    descount.addListener(_updateDiscountedPrice);
  }

  double discountedPrice = 0.0;

  void _updateDiscountedPrice() {
    double originalPrice = double.tryParse(price.text) ?? 0;
    double discountPercent = double.tryParse(descount.text) ?? 0;

    if (discountPercent < 1 || discountPercent > 100) {
      discountedPrice = originalPrice;
    } else {
      discountedPrice = originalPrice - (originalPrice * discountPercent / 100);
    }

    update();
    super.onInit();
  }

  Future<void> selectDurationWithTimePicker() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(hour: 0, minute: 30),
      helpText: 'اختر مدة الخدمة',
      confirmText: 'تم',
      cancelText: 'إلغاء',
    );

    if (picked != null) {
      String durationText = '';
      if (picked.hour > 0) durationText += '${picked.hour} ساعة ';
      if (picked.minute > 0) durationText += '${picked.minute} دقيقة';

      service_time.text =
          durationText.trim(); // أو مثلاً "${picked.hour}:${picked.minute}"
      update();
    }
  }

  Future<dynamic> getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ApiLinks.getCategoriesService,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
        update();
      },
      (data) {
        if (data != null && data is List) {
          categories =
              data.map((item) {
                return CategoryModel.fromJson(item);
              }).toList();
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          categories = [];

          Get.snackbar(
            'خطأ',
            message,
            snackPosition: SnackPosition.TOP,
          ); // عرض رسالة الخطأ
        }
        update();
      },
    );
  }

  /// اختيار عدة صور
  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => File(image.path)).toList());
        update();
      } else {
        Get.snackbar('خطأ', 'لم يتم اختيار صور');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في اختيار الصور: $e');
    }
  }

  Future<void> addService() async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('تنبيه', 'يرجى ملء الحقول بشكل صحيح');
      return;
    }

    if (selectedImages.isEmpty) {
      Get.snackbar('تنبيه', 'يرجى اختيار صورة واحدة على الأقل');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse(ApiLinks.add_service);
      var request = http.MultipartRequest("POST", uri);

      // Headers with token
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['name'] = name.text;
      request.fields['description'] = des.text;
      request.fields['category_id'] = selectedCategory!.id.toString();
      request.fields['price'] = price.text;
      request.fields['time_of_service'] = service_time.text;

      // Attach all selected images
      for (var imageFile in selectedImages) {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', imageFile.path),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodeResponse = json.decode(responseData);
if (response.statusCode == 403 &&
    decodeResponse['message'] == 'Provider does not have an active subscription') {
  Get.snackbar('تنبيه', 'قم بالاشتراك أولاً قبل إضافة الخدمة');
  statusRequest = StatusRequest.failure;
  update();
  return;
}
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeResponse = json.decode(responseData);
        if (isDescount) {
          addDiscount(decodeResponse['product']['id'].toString());
        }

        CustomSnackBar('تم رفع الخدمة بنجاح', true);
        HomeServicesController homeProductController = Get.find();
        homeProductController.getServices();

        statusRequest = StatusRequest.success;
      } else {
        print(responseData);
        CustomSnackBar(
          'فشل في رفع المنتج! رمز الحالة: ${response.statusCode}',
          false,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print("❌ خطأ: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء رفع المنتج',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    name.clear();
    des.clear();
    price.clear();
    service_time.clear();
    selectedImages.clear();
    update();
  }

  addDiscount(String id) async {
    if (descount.text.isEmpty ||
        firstDateDiscount.text.isEmpty ||
        lastDateDiscount.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى تعبئة جميع بيانات الخصم');
      return;
    }

    isLoading.value = true;

    var response = await ApiRemote().AddDiscountModel(
      {
        "value": descount.text,
        "from_time": firstDateDiscount.text,
        "to_time": lastDateDiscount.text,
      },
      ApiLinks.addServiceDiscount,
      id,
    );

    isLoading.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تمت إضافة الخصم بنجاح');
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
    }
  }
}
