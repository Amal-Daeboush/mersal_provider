import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CustomBorderButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomBorderButton(
      {super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      minWidth: double.infinity,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor)),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(
              color: AppColors.primaryColor,
            )
          : Text(
              text,
              style: Styles.style18.copyWith(color: AppColors.red),
            ),
    );
  }
}
