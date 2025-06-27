import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';
import 'package:provider_mersal/view/product/refresh%20product/controller/refresh_product_controller.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../authentication/widget/custom_container_button/custom_container_button.dart';
import '../../../home/widgets/card/custom_small_but.dart';
import '../../../widgets/icons/arrow_back_icon.dart';

class RefreshProductScreen extends StatelessWidget {
  const RefreshProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: HelperFunctions.screenHeight(),
            width: HelperFunctions.screenWidth(),
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                ),
                Container(
                  height: HelperFunctions.screenHeight() / 6,
                  color: AppColors.primaryColor,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage:
                                const AssetImage(AppImageAsset.profile),
                          ),
              ArrowBackIcon(
                            isHomeScreen: false,
                            onTap: () => Get.back(),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          Positioned(
              top: HelperFunctions.screenHeight() / 7,
              child: Container(
                  height: constraints.maxHeight -
                      (HelperFunctions.screenHeight() / 7),
                  width: HelperFunctions.screenWidth(),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  child: GetBuilder(
                      init: RefreshProductController(),
                      builder: (controller) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.defaultSpace, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'تحديث المخزون',
                                  style: Styles.style18
                                      .copyWith(color: AppColors.black),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                             'قم بإدارة كميات المنتجات لضمان استمرارية البيع',
                                  style: Styles.style12
                                      .copyWith(color: AppColors.greyColor4),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CustomTextFormField(
                                    controller: controller.nameController,
                                    hintText: 'اسم المنتج',
                                    obscureText: false,
                                    isPassWord: false),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CustomTextFormField(
                                  controller: controller.descController,
                                  hintText: 'وصف المنتج',
                                  obscureText: false,
                                  isPassWord: false,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CustomTextFormField(
                                    controller: controller.priceController,
                                    hintText: 'السعر',
                                    obscureText: false,
                                    isPassWord: false),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextFormField(
                                    controller: controller.countController,
                                    hintText: 'كمية المخزون',
                                    obscureText: false,
                                    isPassWord: false),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const CustomTextFormField(
                                    enabel: false,
                                    suffixIcon: Icon(
                                      Iconsax.gallery_export,
                                      size: 20,
                                      color: AppColors.black,
                                    ),
                                    hintText: 'صور الخدمة',
                                    obscureText: false,
                                    isPassWord: false),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 100,
                                   mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                   
                                  ),
                                  itemBuilder:
                                    (context, index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          8), // Add rounded corners
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: 100,
                                            color: AppColors.lightGrey3,
                                          ),
                                          const Positioned(
                                            top: 10,
                                            left: 5,
                                            child: const CustomSmallBut(
                                              icon: Icon(
                                                Iconsax.trash,
                                                color: AppColors.red,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    itemCount:
                                        4, // Ensure the list length matches
                               
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CustomContainerButton(
                                  borderColor: AppColors.primaryColor,
                                  color: AppColors.primaryColor,
                                  child: Text(
                                    'تعديل الكمية',
                                    style: Styles.style1
                                        .copyWith(color: AppColors.whiteColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomContainerButton(
                                  borderColor: AppColors.whiteColor2,
                                  color: AppColors.whiteColor2,
                                  child: Text(
                                    'حذف المنتج',
                                    style: Styles.style1
                                        .copyWith(color: AppColors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })))
        ],
      );
    }));
  }
}
