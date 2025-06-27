import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String? count;
  const CustomCard({super.key, required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: title == 'inc' ? AppColors.primaryColor : AppColors.whiteColor,
          boxShadow: const [AppColors.greyShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title == 'feed'
                      ? SvgPicture.asset(AppImageAsset.feedback, height: 15)
                      : title == 'inc'
                      ? SvgPicture.asset(AppImageAsset.increase, height: 15)
                      : SvgPicture.asset(AppImageAsset.order, height: 15),
                  SizedBox(height: 5.h),
                  Text(
                    title == 'feed'
                        ? 'متوسط تقييم العملاء'
                        : title == 'inc'
                        ? 'إجمالي الأرباح'
                        : 'عدد الطلبات',
                    style: Styles.style8.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                          title == 'inc'
                              ? AppColors.whiteColor
                              : AppColors.black,
                    ),
                  ),
                ],
              ),

              //   Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    count == null ? '1000' : count!,
                    textAlign: TextAlign.left,
                    style: Styles.style4.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          title == 'inc'
                              ? AppColors.whiteColor
                              : AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
