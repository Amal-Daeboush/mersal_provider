import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:provider_mersal/view/profile/controller/profile_controller.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

import '../../../core/sevices/sevices.dart';

class EditInfoProfileController extends GetxController {
  File? selectedImage;
  String message = '';
  final ImagePicker picker = ImagePicker();
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  TextEditingController national_id = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  Crud crud = Crud();
  onInit() {
    name.text = ConstData.nameUser;
    national_id.text = ConstData.national;
    super.onInit();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);

        // ✅ استدعاء دالة رفع الصورة
        await postImage(selectedImage!);

        //  CustomSnackBar('Image uploaded successfully', true);
      } else {
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> postImage(File imageFile) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var uri = Uri.parse(
        ConstData.producter
            ? ApiLinks.updateProfileProduct
            : ApiLinks.updateProfileService,
      );
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(ApiLinks().getHeaderWithToken());
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      );
      request.files.add(multipartFile);
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("🔴 Response Data: $responseData");
      print("🔴 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        //  var decodeResponse = json.decode(responseData);

        statusRequest = StatusRequest.success;
        CustomSnackBar('الصورة تم رفعها بنجاح!', true);
        print("✅ الصورة تم رفعها بنجاح!");
        update();
      } else {
        statusRequest = StatusRequest.failure;

        CustomSnackBar('لم يتم العثور على رابط الصورة في الاستجابة!', true);
        update();
        print("❌ لم يتم العثور على رابط الصورة في الاستجابة!");
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("❌ خطأ أثناء رفع الصورة: $e");
    }
  }

  Future<void> updateName() async {
    if (keyForm.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().UpdateInfoProductModel({
        '_method': 'POST',
        'name': name.text,
        'national_id': national_id.text,
      });

      if (response is StatusRequest) {
        // فشل الاتصال
        message =
            response == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالإنترنت'
                : 'حدث خطأ في السيرفر';
        Get.snackbar('خطأ', message);
        return;
      }

      if (response is Map<String, dynamic>) {
        if (response.containsKey('data')) {
          var name = response['data']['name'];
          var national_id = response['data']['national_id'];
          await MyServices.saveValue(SharedPreferencesKey.userName, name);
          await MyServices.saveValue(
            SharedPreferencesKey.national,
            national_id,
          );
          ConstData.nameUser = name;
          ConstData.national = national_id;
          Get.find<ProfileController>().name = name;
          Get.find<ProfileController>().update();
          MyServices().setConstName();
          MyServices().setConstNotationId();

          Get.snackbar('نجاح', 'تم تحديث معلوماتك');
          Get.off(
            BottomNavBarScreen(
              prov:
                  ConstData.producter ? 'product_provider' : 'service_provider',
            ),
          );
        } else if (response.containsKey('message')) {
          Get.snackbar('رسالة', response['message']);
        } else if (response.containsKey('errors')) {
          var errors = response['errors'] as Map<String, dynamic>;
          String errorMessages = errors.values
              .map((list) => (list as List).join('\n'))
              .join('\n');
          Get.snackbar('خطأ', errorMessages);
        } else {
          Get.snackbar('خطأ', 'استجابة غير مفهومة من السيرفر');
        }
      } else {
        Get.snackbar('خطأ', 'من فضلك أدخل معلوماتك كاملة');
      }
    }
  }
}
