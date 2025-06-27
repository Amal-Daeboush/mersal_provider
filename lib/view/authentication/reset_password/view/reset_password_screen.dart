import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_sizes.dart';
import 'package:provider_mersal/view/authentication/reset_password/controller/reset_password_controller.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_button_login.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/logo/custom_logo.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
        init: ResetPasswordController(),
          builder: (controller) {
            return Form(
              key: controller.keyForm,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      CustomLogo(),
                      SizedBox(
                        height: (AppSizes.lg).h,
                      ),
                      Text(
                        ' كلمه المرور',
                        style: Styles.style3,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text('ادخل بريدك الالكترونى لاستعاده كلمه المرور الخاصه بك',textAlign: TextAlign.center,
                          style: Styles.style1.copyWith(color: AppColors.lightGrey)),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFormField(hintText: 'aaa@gmail.com',obscureText: false,isPassWord: false,controller: controller.emailController,),
                      SizedBox(
                        height: 10.h,
                      ),
                       CustomButtonLogin(isLogin: true,textn:false,onTap:controller.register,),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
