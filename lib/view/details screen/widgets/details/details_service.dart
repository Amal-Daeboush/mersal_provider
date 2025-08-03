import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/model/produt_model.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';
import 'cubon_row.dart';

class DetailsService extends StatelessWidget {
  final ProductModel productModel;
  const DetailsService({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
     String formatSmartDate(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final difference = today.difference(aDate).inDays;

      if (difference == 0) {
        return 'اليوم ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (difference == 1) {
        return 'أمس ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else {
        return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.name,
          style: Styles.style6.copyWith(color: AppColors.primaryColorBold),
        ),
        const SizedBox(height: 10),
           Text(
          productModel.description,
          style: Styles.style6.copyWith(color: AppColors.primaryColorBold),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(Iconsax.clock5, color: Colors.grey, size: 15),
            SizedBox(width: 5.w),
            Text(
            productModel.timeOfService??productModel.quantity!,
              style: Styles.style4.copyWith(color: AppColors.charcoalGrey),
            ),
            SizedBox(width: 10.w),
            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
            SizedBox(width: 5.w),
            Text(
              '4.4 (80)',
              style: Styles.style1.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // cuban
         productModel.discountInfo.hasDiscount
            ? CubonRow(
              discount: productModel.discountInfo.discountValue!,
              date: formatSmartDate(productModel.discountInfo.discountEndDate!),
            ):SizedBox(),
        const SizedBox(height: 16),
        const Divider(thickness: 1),
      ],
    );
  }
}
