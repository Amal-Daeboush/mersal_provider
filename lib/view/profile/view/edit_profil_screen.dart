import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';
import 'package:provider_mersal/view/profile/controller/edit_profile_controller.dart';

import '../../../core/constant/styles.dart';
import '../../authentication/widget/custom_container_button/custom_container_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_forward_ios, size: 20.sp),
          ),
        ],
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Iconsax.login)),
        title: Text(
          'تعديل الملف الشخصي',
          style: Styles.style1.copyWith(color: AppColors.black),
        ),
      ),
      body: GetBuilder(
        init: EditInfoProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child:  Form(
                      key: controller.keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.charcoalGrey),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage: AssetImage(AppImageAsset.profile),
                        ),
                      ),
                    ),
                    Text(ConstData.nameUser, style: Styles.style1),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          //   height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Iconsax.trash,
                            size: 20,
                            color: AppColors.red,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: Container(
                            //   height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.border_color_outlined,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        //     IconButton(onPressed: () {}, icon: Icon(Icons.border_color)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: controller.name,
                      hintText: 'اسم المستخدم',
                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(height: 10.h),
                
                    /*    CustomTextFormField(
                      hintText: 'رقم الهاتف',
                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(height: 10.h), */
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: controller.national_id,
                     // enabel: false,
                      suffixIcon: Icon(
                        Iconsax.gallery_export,
                        size: 20,
                        color: AppColors.black,
                      ),
                      hintText: 'رقم الهوية/رخصة القيادة',
                      obscureText: false,
                      isPassWord: false,
                    ),
                    SizedBox(height: 10.h),
                    CustomContainerButton(
                      onTap: () => controller.updateName(),
                      
                      borderColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                      child: Text(
                        'حفظ',
                        style: Styles.style1.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomContainerButton(
                      borderColor: AppColors.whiteColor2,
                      color: AppColors.whiteColor2,
                      child: Text(
                        'الغاء',
                        style: Styles.style1.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
