import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/view/authentication/bank%20details/view/bank_details_screen.dart';
import 'package:provider_mersal/view/authentication/tax%20screen/controller/tax_controller.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/check box/custom_check_box.dart';
import '../../widget/custom_container_button/custom_button_next.dart';
import '../../widget/logo/custom_logo.dart';
import '../../widget/text_field/custom_text_form_field.dart';

class TaxScreen extends StatelessWidget {
  final String prov;
  const TaxScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder(
              init: TaxController(),
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
                        'التفاصيل القانونيه والضريبيه',
                        style: Styles.style20.copyWith(color: AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        ' نحن بحاجه الى التحقق من عملك',
                        style:
                            Styles.style4.copyWith(color: AppColors.lightGrey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const CustomTextFormField(
                        //   controller: controller.nameController,
                        hintText: 'الاسم التجاري',
                        obscureText: false,
                        isPassWord: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CustomTextFormField(
                        hintText: 'رقم الرخصه التجاريه',
                        obscureText: false,
                        isPassWord: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CustomTextFormField(
                        hintText: 'تاريخ انتهاء صلاحيه الرخصه التجاريه',
                          suffixIcon: Icon(
                                      Iconsax.calendar_1,
                                      size: 20,
                                      color: AppColors.black,
                                    ),
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
                            'هل تم تسجيل عملك لضريبه القيمه المضافه؟',
                            style:
                                Styles.style1.copyWith(color: AppColors.black),
                          )),
                          SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          buildCheckBox('نعم', controller.isYesChecked,
                              () => controller.onSelect(true)),
                          SizedBox(width: 10.h),
                          buildCheckBox('لا', !controller.isYesChecked,
                              () => controller.onSelect(false)),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CustomTextFormField(
                        //   controller: controller.nameController,
                        hintText: 'نسبه ضريبه القيمه المضافه',
                        obscureText: false,
                        isPassWord: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CustomTextFormField(
                        hintText: 'الرقم الضريبى',
                        obscureText: false,
                        isPassWord: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CustomTextFormField(
                        hintText: 'رقم الهويه الوطنيه او جواز السفر',
                        obscureText: false,
                        isPassWord: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                       CustomButtonNext(
                        onTap: () =>Get.off(BankDetailsScreen(prov: prov,)) ,
                       ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ));
              })),
    );
  }
}
