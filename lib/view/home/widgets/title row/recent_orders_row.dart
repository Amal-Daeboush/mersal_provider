import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class RecentOrdersRow extends StatelessWidget {
  const RecentOrdersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الطلبات الأخيرة',
                        style: Styles.style1.copyWith(
                            color: AppColors.primaryColorBold,
                            fontWeight: FontWeight.w500),
                      ),
                          Text(
                        'الكل',
                        style: Styles.style1.copyWith(
                            color: AppColors.primaryColorBold,
                            fontWeight: FontWeight.w500),
                      ),
                   
                    ],
                  ),
    );
  }
}