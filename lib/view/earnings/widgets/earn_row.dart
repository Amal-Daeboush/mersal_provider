import 'package:flutter/material.dart';
import 'package:provider_mersal/model/earn_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class EarnRow extends StatelessWidget {
  final EarnModel earn;
  const EarnRow({super.key, required this.earn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          earn.date,
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.id.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.sub_price.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.total_price.toString(),
          style: Styles.style5.copyWith(color: AppColors.black),
        ),
        Text(
          earn.status,
          style: Styles.style5.copyWith(
              color: earn.status == 'معلقه' ? AppColors.red : AppColors.black),
        ),
      ],
    );
  }
}
