import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/view/food%20types/view/food_types_screen.dart';

import '../../../../core/class/helper_functions.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../../core/constant/styles.dart';
import '../../../subscribe/view/subscribe_screen.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            AppImageAsset.discount,
            height: 150.h,
            fit: BoxFit.fill,
            width: HelperFunctions.screenWidth(),
          ),
        ),
        Positioned(
          right: 10,
          top: 20,
          child: Text(
            ConstData.user!.user.type == 'food_provider'
                ? 'تصفح اصناف الطعام التي لديك\n   واضف المزيد الان'
                : 'احصل على خصم يصل الى\n 50% عند الخدمه الاولى',
            style: Styles.style4.copyWith(
              color:
                  ConstData.user!.user.type == 'food_provider'
                      ? AppColors.primaryColorBold
                      : AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: AppColors.whiteColor,
            ),
            child: GestureDetector(
              onTap:
                  ConstData.user!.user.type == 'service_provider'
                      ? () => Get.to(SubscribeScreen()):    ConstData.user!.user.type == 'food_provider'?
                       () => Get.to(FoodTypesScreen())
                      : () {},
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'اكتشف أكثر',
                  style: Styles.style5.copyWith(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
