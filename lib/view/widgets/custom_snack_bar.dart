import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

SnackbarController CustomSnackBar(String title, bool isTop) {
  return Get.snackbar(
    '', '',
    snackStyle: SnackStyle.FLOATING,
    colorText: AppColors.black,
    snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8), // تقليل الهوامش الخارجية
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    titleText:
        Text(title, style: Styles.style3.copyWith(color: AppColors.black)),
    messageText: SizedBox.shrink(),
  );
}
