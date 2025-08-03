import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CubonRow extends StatelessWidget {
  final String discount;
  final String date;
  const CubonRow({super.key, required this.discount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: ' يوجد خصم  ',
                style: Styles.style4.copyWith(color: AppColors.charcoalGrey)),
            TextSpan(
                text: '$discount %',
                style: Styles.style4.copyWith(color: AppColors.primaryColor)),
            TextSpan(
                text: ' صالح حتى $date',
                style: Styles.style4.copyWith(color: AppColors.charcoalGrey))
          ])),
          Icon(Icons.percent, size: 20.sp, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}