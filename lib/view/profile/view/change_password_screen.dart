import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_container_button.dart';
import 'package:provider_mersal/view/profile/controller/change_password_controller.dart';
import 'package:provider_mersal/view/widgets/app%20bar/container_app_bar.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../authentication/widget/text_field/custom_text_form_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ChangePasswordController>(
          init: ChangePasswordController(),
          builder: (controller) {
            return Form(
              key: controller.keyForm,

              child:
                  controller.statusRequest == StatusRequest.loading
                      ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 120.w,
                          vertical: 50.h,
                        ),
                        child: customLoadingIndictor(),
                      )
                      : Column(
                        children: [
                          ContainerAppBar(
                            isSearch: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    'الرقم السري',
                                    style: Styles.style1.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.whiteColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        'الرقم السرى',
                                        style: Styles.style6.copyWith(
                                          color: AppColors.charcoalGrey,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'تحديث كلمه المرور لتعزيز امان الحساب',
                                        style: Styles.style1.copyWith(
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.greyColor2,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Iconsax.lock, size: 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormField(
                                      controller: controller.oldpass,
                                      hintText: 'كلمه المرور الحاليه',
                                      obscureText: false,
                                      isPassWord: false,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomTextFormField(
                                      controller: controller.newpass,
                                      hintText: ' كلمة المرور الجديدة',
                                      obscureText: false,
                                      isPassWord: false,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomTextFormField(
                                      controller: controller.confirmpass,
                                      hintText: '  تأكيد كلمة المرور الجديدة',
                                      obscureText: false,
                                      isPassWord: false,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'يجب ان تتكون كلمه المرور من 8 احرف على الاقل ويجب ان تتضمن ',
                                      style: Styles.style4.copyWith(
                                        color: AppColors.charcoalGrey,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      '1حرف كبير (A-Z)\n1حرف صغير (a-z)\n1 رقم(0-9)\n1 حرف خاص (/?.,+=-*&^%/\$£”)',
                                      style: Styles.style8,
                                    ),
                                    SizedBox(height: 20.h),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: CustomContainerButton(
                                        onTap: controller.updatepassword,
                                        borderColor: AppColors.primaryColor,
                                        color: AppColors.primaryColor,
                                        child: Text(
                                          'حفظ',
                                          style: Styles.style1.copyWith(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: CustomContainerButton(
                                        borderColor: AppColors.whiteColor2,
                                        color: AppColors.whiteColor2,
                                        child: Text(
                                          'الغاء',
                                          style: Styles.style1.copyWith(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            );
          },
        ),
      ),
    );
  }
}
