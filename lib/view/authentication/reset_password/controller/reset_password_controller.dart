import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  void register() {
    if (keyForm.currentState?.validate() ?? false) {
      // Get.off(LoginPhoneScreen());
    } else {
      Get.snackbar(
        'Error',
        'Please correct the errors in the form',
        backgroundColor: AppColors.whiteColor2,
      );
    }
  }
}
