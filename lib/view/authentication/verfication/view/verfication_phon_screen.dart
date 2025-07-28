import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/authentication/verfication/controller/verification_controller.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_button_next.dart';
import 'package:provider_mersal/view/widgets/loading/custom_loading.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../login/screen/login.dart';
import '../../widget/custom_container_button/custom_container_button.dart';
import '../../widget/logo/custom_logo.dart';
import '../../widget/otp/otp_text_field.dart';

class VerificationPhonScreen extends StatelessWidget {
  final String email;
  final bool isForgetpass;
  const VerificationPhonScreen({
    super.key,
    required this.email,
    required this.isForgetpass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: VerificationController(email: email),
          builder: (controller) {
            return Stack(
              children: [
                SingleChildScrollView(
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
                          style: Styles.style1.copyWith(
                            color: AppColors.lightGrey,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        OtpVerificationTextField(
                          /*        onSubmit: (otpValue) {
                          controller.verificationCode = otpValue;
                        }, */
                        ),
                        SizedBox(height: 20.h),
                        CustomButtonNext(
                          onTap:
                              isForgetpass
                                  ? controller.ResetPassEmail
                                  : controller.VerificationEmail,
                        ),
                        SizedBox(height: 10.h),
                        isForgetpass
                            ? SizedBox()
                            : CustomContainerButton(
                              onTap: controller.ResendVerificationEmail,
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
                          style: Styles.style4.copyWith(
                            color: AppColors.lightGrey,
                          ),
                        ),
                        Text(
                          'على شروط الخدمه وسياسه الخصوصيه الخاصه بنا',
                          style: Styles.style4.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ' هل تريد اعادة تسجيل الدخول؟ ',
                                  style: Styles.style4.copyWith(
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                                TextSpan(
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.off(
                                            LoginScreen(),
                                          ); // الانتقال إلى شاشة التسجيل
                                        },
                                  text: 'قم بتسجيل الدخول',
                                  style: Styles.style4.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (controller.statusRequest == StatusRequest.loading)
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Center(child: CustomLoading()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
