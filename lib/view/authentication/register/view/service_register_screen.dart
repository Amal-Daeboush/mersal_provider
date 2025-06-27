import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/address/screen/address.dart';
import 'package:provider_mersal/view/authentication/register/controller/service_register_controller.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/check box/custom_check_box.dart';
import '../../widget/custom_container_button/custom_button_next.dart';
import '../../widget/logo/custom_logo.dart';
import '../../widget/text_field/custom_text_form_field.dart';

class ServiceRegisterScreen extends StatelessWidget {
  final String prov;
  const ServiceRegisterScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GetBuilder(
          init: ServiceRegisterController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    const CustomLogo(),
                    SizedBox(
                      height: (AppSizes.lg).h,
                    ),
                    Text(
                      'اخبرنا عن عملك',
                      style: Styles.style20.copyWith(color: AppColors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'سينمكن العملاء من رؤيه هذه المعلومات على تطبيق مرسال للبحث والتواصل معك',
                      style: Styles.style4.copyWith(color: AppColors.lightGrey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'اسم العلامه التجاريه',
                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'وصف تفصيلي للمنتجات المقدمة',
                      maxLines: 3,
                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'نوع العمل',

                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'عدد الفروع',

                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'دورك في العمل',

                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const CustomTextFormField(
                      // controller: controller.nameController,
                      hintText: 'رقم التواصل',

                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'هل لديك سجل تجاري؟',
                          style: Styles.style1.copyWith(color: AppColors.black),
                        )),
                   const     SizedBox()
                      ],
                    ),
                    buildCheckBox('نعم', controller.isYesChecked,
                        () => controller.onSelect(true)),
                      SizedBox(height: 10.h),
                    buildCheckBox('لا', !controller.isYesChecked,
                        () => controller.onSelect(false)),
                    SizedBox(
                      height: 15.h,
                    ),
                     CustomButtonNext(
                      onTap: () =>Get.off(AddressScreen(isfromHome: false),) 
                     ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
