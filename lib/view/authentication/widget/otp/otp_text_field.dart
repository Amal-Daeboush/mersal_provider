import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../verfication/controller/verification_controller.dart';

class OtpVerificationTextField extends GetView<VerificationController> {
  const OtpVerificationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Force LTR direction
      child: OtpTextField(
        keyboardType: TextInputType.text,
        margin: EdgeInsets.all(2),
        
        numberOfFields: 6,
        fillColor: AppColors.whiteColor2,
        filled: true,
        focusedBorderColor: AppColors.whiteColor2,

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      //  fieldWidth: 50.w,
      //  fieldHeight: 60.h,
        //  borderColor: AppColors.primaryColor,
        borderWidth: 1,
        showFieldAsBox: true,
        onSubmit: (String verificationCode) {
          controller.verificationCode = verificationCode;
        },
      ),
    );
  }
}
