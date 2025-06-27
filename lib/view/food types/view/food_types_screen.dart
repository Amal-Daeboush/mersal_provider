import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/food%20types/controller/food_types_controller.dart';
import 'package:provider_mersal/view/food%20types/widget/add_food_type_dialog.dart';
import 'package:provider_mersal/view/food%20types/widget/food_type_card.dart';
import 'package:provider_mersal/view/subscribe/controller/subscribe_controller.dart';
import 'package:provider_mersal/view/subscribe/widgets/my_sub_card.dart';
import 'package:provider_mersal/view/subscribe/widgets/sub_dialog.dart';
import 'package:provider_mersal/view/subscribe/widgets/sub_shimmer.dart';
import 'package:provider_mersal/view/subscribe/widgets/subscribe_app_bar.dart';
import 'package:provider_mersal/view/subscribe/widgets/subscribe_card.dart';
import 'package:provider_mersal/view/widgets/custom_button_service.dart/service_button.dart';

import '../../../core/constant/app_colors.dart';

import '../../../core/constant/styles.dart';

class FoodTypesScreen extends StatelessWidget {
  const FoodTypesScreen({super.key});

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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SubscribeAppBar(isSubscrib: false),
                      ),
                    ),
                  ],
                ),
              ),

              GetBuilder(
                init: FoodTypesController(),
                builder: (controller) {
                  return Positioned(
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
                        padding: const EdgeInsets.all(8.0),

                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10.h),

                              // في حالة التحميل
                              if (controller.statusRequestFood ==
                                  StatusRequest.loading)
                                ...List.generate(3, (index) => SubShimmerCard())
                              // في حالة لا توجد أصناف
                              else if (controller.myfoodtypes.isEmpty)
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'لم تقم باختيار أصناف أطباقك، أضف الآن',
                                    ),
                                  ),
                                )
                              // في حالة وجود أصناف
                              else
                                ...controller.myfoodtypes.map((foodType) {
                                  return FoodTypeCard(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: '',
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                  ),
                                              child: Text(
                                                'لا',
                                                style: Styles.style4,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteFoodType(
                                                foodType.id.toString(),
                                              );
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                  ),
                                              child: Text(
                                                'نعم',
                                                style: Styles.style4.copyWith(
                                                  color: AppColors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        content: Text(
                                          'هل انت متأكد من حذف نوع الطعام؟',
                                          style: Styles.style1,
                                        ),
                                      );
                                    },
                                    foodTypeModel: foodType,
                                  );
                                }).toList(),

                              SizedBox(height: 30.h),
                          //    Spacer(),
                              // زر الإضافة
                              ServiceButton(
                                title: 'اضف صنف جديد',
                                onPressed: () async {
                                  if (controller.foodtypes.isEmpty) {
                                    await controller.getFoodTypes();
                                  }

                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AddFoodTypeDialog(
                                          controller: controller,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
