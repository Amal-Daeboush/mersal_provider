import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';

void showSubscribeDialog(BuildContext context, VoidCallback onConfirm) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedValue = Curves.easeInOut.transform(animation.value);

      return Transform.translate(
        offset: Offset(0, -100 + (100 * (1 - curvedValue))),
        child: Opacity(
          opacity: animation.value,
          child: Center(
            child: SizedBox(
              width: 350.w, 
              height: 250,// 👈 عرض الديالوغ
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                title: const Text(
                  '',
                  style: TextStyle(fontSize: 0),
                ),
                content: Text(
                  'هل تريد الاشتراك بهذا العرض؟',
                  style: Styles.style1.copyWith(fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'لا',
                      style: Styles.style4,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                    child: Text(
                      'نعم',
                      style: Styles.style4.copyWith(color: AppColors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
