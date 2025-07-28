import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/view/authentication/login/screen/login.dart';
import 'package:provider_mersal/view/authentication/register/view/register_screen.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_button_login.dart';
import '../../widget/logo/custom_logo.dart';
import '../controller/authentication_controller.dart';
import '../widgets/auth_drop_dow.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: AuthenticationController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      CustomLogo(),
                      SizedBox(
                        height: (AppSizes.lg).h,
                      ),
                      Text(
                        'اختر الفئة',
                        style: Styles.style3.copyWith(color: AppColors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'حدد نوع حسابك للبدء في تقديم خدماتك أو عرض منتجاتك بسهولة',
                        style:
                            Styles.style4.copyWith(color: AppColors.lightGrey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: AuthDropDow(
                              selectedValue: controller.selectedValue,
                              onChanged: controller.onChanged,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButtonLogin(
                          onTap: () => Get.off( RegisterScreen(proveder: controller.selectedValue,)),
                          isLogin: false,
                          textn: false),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButtonLogin(
                          onTap: () => Get.off( LoginScreen()),
                          isLogin: true,
                          textn: false),
                    ],
                  ),
                ),
              );
            }));
  }
}
