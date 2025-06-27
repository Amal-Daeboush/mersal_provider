import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../../core/constant/styles.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // أيقونات التحكم (حذف - تحديث - تعديل)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: shimmerBox(width: 20, height: 20, radius: 5),
                        ),
                      ),
                    ),
                    // السعر
                    shimmerBox(width: 50, height: 20, radius: 5),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            // اسم المنتج وتقييمه
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerBox(width: 70, height: 15),
                shimmerBox(width: 50, height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerBox({required double width, required double height, double radius = 6}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
