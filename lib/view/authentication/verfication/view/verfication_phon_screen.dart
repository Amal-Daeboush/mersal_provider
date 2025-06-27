import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/authentication/verfication/controller/verification_controller.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_button_next.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_container_button.dart';
import '../../widget/logo/custom_logo.dart';
import '../../widget/otp/otp_text_field.dart';

class VerificationPhonScreen extends StatelessWidget {
  final String provider;
  final String email;
  const VerificationPhonScreen({
    super.key,
    required this.email,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: VerificationController(provider: provider),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80.h),
                    CustomLogo(),
                    SizedBox(height: (AppSizes.lg).h),
                    Text('التحقق من الايميل', style: Styles.style3),
                    SizedBox(height: 5.h),
                    Text(
                      'لقد ارسلنا للتو رمزا الى $email  ',
                      style: Styles.style1.copyWith(color: AppColors.lightGrey),
                    ),
                    SizedBox(height: 10.h),
                    OtpVerificationTextField(
                      /*        onSubmit: (otpValue) {
                      controller.verificationCode = otpValue;
                    }, */
                    ),
                    SizedBox(height: 20.h),
                    CustomButtonNext(onTap: controller.checkVerificationCode),
                    SizedBox(height: 10.h),
                    CustomContainerButton(
                      borderColor: AppColors.whiteColor2,
                      color: AppColors.whiteColor2,
                      child: Text(
                        'ارسال مره اخرى',
                        style: Styles.style1.copyWith(
                          color: AppColors.charcoalGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      ' من خلال التسجيل فأنك توافق',
                      style: Styles.style4.copyWith(color: AppColors.lightGrey),
                    ),
                    Text(
                      'على شروط الخدمه وسياسه الخصوصيه الخاصه بنا',
                      style: Styles.style4.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
