import 'package:flutter/material.dart';
import 'package:provider_mersal/model/commission_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class EarnRow extends StatelessWidget {
  final CommissionDetail earn;
  const EarnRow({super.key, required this.earn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
       earn.date!,
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.orderId.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.commission.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.orderAmount.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.status == 'pending'
              ? 'معلقة'
              : earn.status == 'accepted'
              ? 'مقبولة'
              : earn.status == 'on_way'
              ? 'على الطريق'
              : earn.status == 'complete'
              ? 'مكتملة'
              : "مرفوضة",
          style: Styles.style5.copyWith(
            color: earn.status == 'pending' ? AppColors.red : AppColors.black,
          ),
        ),
      ],
    );
  }
}
