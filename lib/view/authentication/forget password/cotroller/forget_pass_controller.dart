import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import '../../../../core/constant/api_links.dart';
import '../../../../model/api remote/api_remote.dart';
import '../../verfication/view/verfication_phon_screen.dart';

class ForgetPassController extends GetxController {
  bool isValidatePhone = false;
  StatusRequest statusRequest = StatusRequest.none;
  final GlobalKey<FormState> keyFormphone = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  void checkNumberValidate(String value) {
    isValidatePhone = value.length == 11 && value.startsWith('01');

    update();
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'ادخل الايميل ';
    }

    return null;
  }

  void ForgetPass() async {
    if (keyFormphone.currentState?.validate() ?? false) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().verificationModel(
        {'email': emailController.text},
        ApiLinks.forget_pass,
        false,
      );

      print("Response: $response");

      if (response == StatusRequest.success) {
        Get.snackbar('نجاح', ' .تم ارسال رمز التحقق الى ايميلك.');

        statusRequest = StatusRequest.success;
        Get.off(
          VerificationPhonScreen(
            email: emailController.text,
            isForgetpass: true,
          ),
        );

        //    Get.off(AddressScreen(isfromHome: false));
        //   Get.off(LoginScreen(provider: provider));
      } else if (response is String) {
        // ✅ عرض رسالة الخطأ بشكل مناسب
        Get.snackbar('Error', response);

        statusRequest = StatusRequest.failure;
      } else {
        Get.snackbar('خطأ', 'حدث خطأ');

        statusRequest = StatusRequest.failure;
      }

      update();
    } else {
     
    }
  }
}
