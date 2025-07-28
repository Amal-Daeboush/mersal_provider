import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  String message = '';

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك املىء الحقل  ';
    }

    if (value.length < 8) {
      return 'يجب ان تكون كلمة السر لا تقل عن 8 محارف';
    }

    return null;
  }

  updatepassword() async {
    if (keyForm.currentState!.validate() && newpass.text == confirmpass.text) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().UpdateInfoProductModel({
        '_method': 'POST',
        // 'current_password': oldpass.text,
        'password': newpass.text,
        'password_confirmation': confirmpass.text,
      });

      print("🚀  response: $response");

      if (response == StatusRequest.success) {
        statusRequest = StatusRequest.success;
        message = 'تم تغيير كلمة المرور بنجاح';
        update();
        CustomSnackBar(message, true);
        Get.back();
      }
      // لو الرد من السيرفر هو Map يحوي رسائل خطأ
      else if (response is Map) {
        if (response.containsKey('message')) {
          message = response['message'] ?? 'حدث خطأ';
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        } else if (response.containsKey('errors')) {
          Map<String, dynamic> errors = response['errors'];
          String errorMessages = errors.values
              .map((list) => (list as List).join('\n'))
              .join('\n');
          message = errorMessages;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        } else {
          message = 'حدث خطأ غير معروف';
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        }
        statusRequest = StatusRequest.failure;
        update();
      } else if (response is String) {
        statusRequest = StatusRequest.failure;
        message = response;
        update();
        Get.snackbar('خطأ', message);
      } else {
        statusRequest = StatusRequest.failure;
        message = 'حدث خطأ';
        update();
        Get.snackbar('خطأ', message);
      }

      // تنظيف الحقول دائماً بعد محاولة التحديث
      oldpass.clear();
      newpass.clear();
      confirmpass.clear();
    } else {
      Get.snackbar(
        'خطأ',
        'يرجى التأكد من صحة البيانات وإدخال كلمة المرور الجديدة بشكل مطابق',
      );
      oldpass.clear();
      newpass.clear();
      confirmpass.clear();
    }

    update();
  }
}
