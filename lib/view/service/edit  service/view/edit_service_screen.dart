import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';
import 'package:provider_mersal/view/product/widgets/category_drop_down.dart';
import 'package:provider_mersal/view/product/widgets/discount_dialog.dart';
import 'package:provider_mersal/view/product/widgets/row_drop_down.dart';
import 'package:provider_mersal/view/service/edit%20%20service/controller/edit_service_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../authentication/widget/custom_container_button/custom_container_button.dart';
import '../../../discount/view/edit_discount_dialog.dart' show EditDiscountDialog;
import '../../../home/widgets/card/custom_small_but.dart';
import '../../../widgets/icons/arrow_back_icon.dart';

class EditServiceScreen extends StatelessWidget {
  final ProductModel productModel;
  const EditServiceScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: HelperFunctions.screenHeight(),
                width: HelperFunctions.screenWidth(),
                child: Stack(
                  children: [
                    Container(color: Colors.grey[200]),
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
                ConstData.image.isEmpty
                    ? const AssetImage(AppImageAsset.user)
                    : NetworkImage(ConstData.image) as ImageProvider,
          ),
                            ArrowBackIcon(
                              isHomeScreen: false,
                              onTap: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: HelperFunctions.screenHeight() / 7,
                child: Container(
                  height:
                      constraints.maxHeight -
                      (HelperFunctions.screenHeight() / 7),
                  width: HelperFunctions.screenWidth(),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: GetBuilder(
                    init: EditServiceController(productModel: productModel),
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                          vertical: 10,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                                                    if (productModel.discountInfo.hasDiscount)
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red[600],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              EditDiscountDialog(
                                                context,
                                                productModel,
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.discount,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'يوجد خصم ${productModel.discountInfo.discountValue}% - اضغط للتفاصيل',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                              Center(
                                child: Text(
                                  'تعديل الخدمة',
                                  style: Styles.style18.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: Text(
                                  'قم بتعديل التفاصيل الخاصة بخدمتك الجديدة لتمكين العملاء من الوصول إليها بسهولة.',
                                  style: Styles.style12.copyWith(
                                    color: AppColors.greyColor4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                controller: controller.nameController,
                                hintText: 'اسم المنتج',
                                obscureText: false,
                                isPassWord: false,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                controller: controller.descController,
                                hintText: 'وصف المنتج',
                                obscureText: false,
                                isPassWord: false,
                                maxLines: 3,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                controller: controller.priceController,
                                hintText: 'السعر',
                                obscureText: false,
                                isPassWord: false,
                              ),
                                !productModel.discountInfo.hasDiscount
                                          ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    value:
                                                        controller.isDescount,
                                                    onChanged: (value) {
                                                      controller.isDescount =
                                                          value!;
                                                      print(
                                                        controller.isDescount,
                                                      );
                                                      controller.update();
                                                    },
                                                  ),
                                                  Text(
                                                    "هل تريد اضافة خصم على منتجك ؟",
                                                  ),
                                                ],
                                              ),
                                              if (controller.isDescount)
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDiscountDialog(
                                                      context,
                                                      controller.descount,
                                                      controller
                                                          .firstDateDiscount,
                                                      controller
                                                          .lastDateDiscount,
                                                     () {
                                                        controller.addDiscount(
                                                          productModel.id
                                                              .toString(),
                                                        );
                                                      },
                                                    );

                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors
                                                            .primaryColor, // لون الزر زهري
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ), // زوايا شبه مستطيلة
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 12,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "أدخل  الخصم",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                          : SizedBox(),

                                      SizedBox(height: 10.h),

                            RowDropDown(
                                        title: 'الفئة',
                                        drop: CategoryDropDown(
                                          categories: controller.categories,
                                          selectedCategory:
                                              controller.selectedCategory,
                                          onChanged: (value) {
                                            controller.setSelectedCategory(
                                              value,
                                            );
                                          },
                                        ),
                                      ),
                              SizedBox(height: 10.h),
                              CustomTextFormField(
                                controller: controller.service_time,
                                onTap: () {
                                  controller.selectDurationWithTimePicker();
                                },

                                icon: Icon(
                                  Iconsax.timer_1,
                                  size: 20,
                                  color: AppColors.black,
                                ),
                                hintText: 'مده الخدمه',
                                obscureText: false,
                                isPassWord: true,
                              ),

                              SizedBox(height: 10.h),
                              RowDropDown(
                                title: 'اختيار صور',
                                drop: IconButton(
                                  onPressed: () => controller.pickImages(),
                                  icon: Icon(
                                    Iconsax.gallery_export,
                                    size: 15,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),

                              GridView.custom(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverWovenGridDelegate.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 0,
                                  pattern: [
                                    const WovenGridTile(1),
                                    const WovenGridTile(
                                      5 / 7,
                                      crossAxisRatio: 0.9,
                                      alignment: AlignmentDirectional.centerEnd,
                                    ),
                                  ],
                                ),
                                childrenDelegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final imageFile =
                                        controller.selectedImages[index];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(imageFile),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.selectedImages
                                                    .removeAt(index);
                                                controller.update();
                                              },
                                              child: const CustomSmallBut(
                                                icon: Icon(
                                                  Iconsax.trash,
                                                  color: AppColors.red,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: controller.selectedImages.length,
                                ),
                              ),

                              SizedBox(height: 15.h),
                              Center(
                                child: CustomContainerButton(
                                  onTap: controller.updateService,
                                  borderColor: AppColors.primaryColor,
                                  color: AppColors.primaryColor,
                                  child: Text(
                                    'حفظ المنتج',
                                    style: Styles.style1.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
