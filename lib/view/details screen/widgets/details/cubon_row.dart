import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CubonRow extends StatelessWidget {
  const CubonRow({super.key});

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
                text: ' وفر ',
                style: Styles.style4.copyWith(color: AppColors.charcoalGrey)),
            TextSpan(
                text: '100',
                style: Styles.style4.copyWith(color: AppColors.primaryColor)),
            TextSpan(
                text: '  مع استخدام كود nour123',
                style: Styles.style4.copyWith(color: AppColors.charcoalGrey))
          ])),
          Icon(Icons.percent, size: 20.sp, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
