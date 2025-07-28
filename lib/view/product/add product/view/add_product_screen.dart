import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';
import 'package:provider_mersal/view/home/widgets/card/custom_small_but.dart';
import 'package:provider_mersal/view/product/add%20product/controller/add_product_controller.dart';
import 'package:provider_mersal/view/product/widgets/category_drop_down.dart'
    show CategoryDropDown;
import 'package:provider_mersal/view/product/widgets/category_food_types.dart';
import 'package:provider_mersal/view/product/widgets/discount_dialog.dart';
import 'package:provider_mersal/view/product/widgets/row_drop_down.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../authentication/widget/custom_container_button/custom_container_button.dart';
import '../../../widgets/icons/arrow_back_icon.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isfood;
    if (ConstData.user!.user.type == 'food_provider') {
      isfood = true;
    } else {
      isfood = false;
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GetBuilder(
            init: AddProductController(),
            builder: (controller) {
              double finalPrice = controller.calculateDiscountedPrice();
              return Form(
                key: controller.keyForm,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundImage: const AssetImage(
                                      AppImageAsset.profile,
                                    ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.defaultSpace,
                            vertical: 10,
                          ),
                          child:
                              controller.statusRequest == StatusRequest.loading
                                  ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 100.w,
                                      vertical: 100.h,
                                    ),
                                    child: Center(
                                      child: customLoadingIndictor(),
                                    ),
                                  )
                                  : SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            isfood
                                                ? 'إضافة طبق جديد'
                                                : 'إضافة منتج جديد',
                                            style: Styles.style18.copyWith(
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Center(
                                          child: Text(
                                            isfood
                                                ? 'قم بإضافة التفاصيل الخاصة بطبقك الجديد لتمكين العملاء من الوصول إليها بسهولة.'
                                                : 'قم بإضافة التفاصيل الخاصة بمنتجك الجديدة لتمكين العملاء من الوصول إليها بسهولة.',
                                            style: Styles.style12.copyWith(
                                              color: AppColors.greyColor4,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        CustomTextFormField(
                                          hintText:
                                              isfood
                                                  ? 'اسم الطبق'
                                                  : 'اسم المنتج',
                                          controller: controller.name,
                                          obscureText: false,
                                          isPassWord: false,
                                        ),
                                        SizedBox(height: 15.h),
                                        CustomTextFormField(
                                          controller: controller.des,
                                          hintText:
                                              isfood
                                                  ? 'وصف الطبق'
                                                  : 'وصف المنتج',
                                          obscureText: false,
                                          isPassWord: false,
                                          maxLines: 3,
                                        ),
                                        SizedBox(height: 15.h),
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
                                        SizedBox(height: 15.h),

                                        isfood
                                            ? RowDropDown(
                                              title:' نوع الطعام',
                                              drop: CategoryFoodTypes(
                                                types: controller.foodtypes,
                                                selectedFood:
                                                    controller.selectedFood,
                                                onChanged: (value) {
                                                  controller.setSelectedFood(
                                                    value,
                                                  );
                                                },
                                              ),
                                            )
                                            : SizedBox(),
                                        SizedBox(height: 15.h),
                                        CustomTextFormField(
                                          keyboardType: TextInputType.number,
                                          hintText: 'السعر',
                                          obscureText: false,
                                          controller: controller.price,
                                          isPassWord: false,
                                        ),
                                        SizedBox(height: 5.h),
                                        controller.isDescount
                                            ? Text(
                                              "السعر بعد الخصم: ${controller.discountedPrice.toStringAsFixed(2)}",
                                                style: Styles.style2.copyWith(
                                            color: AppColors.red,
                                            fontSize: 10.sp,
                                          ),
                                            )
                                            : SizedBox(),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: controller.quantity,
                                          hintText: 'كمية المخزون',
                                          obscureText: false,
                                          isPassWord: false,
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: controller.isDescount,
                                              onChanged: (value) {
                                                controller.isDescount = value!;
                                                print(controller.isDescount);
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
                                                controller.firstDateDiscount,
                                                controller.lastDateDiscount,
                                                () {},
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
                                              padding: EdgeInsets.symmetric(
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
                                        SizedBox(height: 10.h),
                                        RowDropDown(
                                          title: 'اختيار صور',
                                          drop: IconButton(
                                            onPressed:
                                                () => controller.pickImages(),
                                            icon: Icon(
                                              Iconsax.gallery_export,
                                              size: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                        GridView.custom(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 0,
                                                pattern: [
                                                  const WovenGridTile(1),
                                                  const WovenGridTile(
                                                    5 / 7,
                                                    crossAxisRatio: 0.9,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerEnd,
                                                  ),
                                                ],
                                              ),
                                          childrenDelegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              final imageFile =
                                                  controller
                                                      .selectedImages[index];

                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: FileImage(
                                                            imageFile,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 5,
                                                      left: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedImages
                                                              .removeAt(index);
                                                          controller.update();
                                                        },
                                                        child:
                                                            const CustomSmallBut(
                                                              icon: Icon(
                                                                Iconsax.trash,
                                                                color:
                                                                    AppColors
                                                                        .red,
                                                                size: 15,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            childCount:
                                                controller
                                                    .selectedImages
                                                    .length,
                                          ),
                                        ),

                                        SizedBox(height: 15.h),
                                        Center(
                                          child: CustomContainerButton(
                                            onTap: controller.addProduct,
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
                                        Center(
                                          child: CustomContainerButton(
                                            onTap: () => Get.back(),
                                            borderColor: AppColors.whiteColor2,
                                            color: AppColors.whiteColor2,
                                            child: Text(
                                              'الغاء',
                                              style: Styles.style1.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    if (controller.statusRequestFood == StatusRequest.loading)
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: const Card(
                          color: AppColors.primaryColorBold,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            child: Text(
                              'يرجى الانتظار قليلاً حتى يتم جلب كل المعلومات...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
