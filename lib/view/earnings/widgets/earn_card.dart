import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class EarnCard extends StatelessWidget {
  final String title;
  const EarnCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color:
                title == 'pend' ? AppColors.primaryColor : AppColors.whiteColor,
            boxShadow: const [AppColors.greyShadow]),
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
                  SvgPicture.asset(
                    AppImageAsset.increase,
                    color:    title == 'pend'?AppColors.whiteColor:AppColors.primaryColor,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    title == 'pend'
                        ? 'الأرباح المعلقة'
                        : title == 'all'
                            ? 'الاجمالي الكلي'
                            : 'الأرباح المدفوعة',
                    style: Styles.style8.copyWith(
                        fontWeight: FontWeight.w500,
                        color: title == 'pend'
                            ? AppColors.whiteColor
                            : AppColors.black),
                  ),
                ],
              ),

              //   Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '1000',
                    textAlign: TextAlign.left,
                    style: Styles.style4.copyWith(
                        fontWeight: FontWeight.w600,
                        color: title == 'pend'
                            ? AppColors.whiteColor
                            : AppColors.black),
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
