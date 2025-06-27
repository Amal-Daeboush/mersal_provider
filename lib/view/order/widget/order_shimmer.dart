import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/constant/app_colors.dart';

class ReservationCardShimmer extends StatelessWidget {
  const ReservationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget shimmerBox({
      double width = 100,
      double height = 15,
      double radius = 5,
    }) {
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorWithOpacity2,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // تاريخ الطلب
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: shimmerBox(width: 50, height: 30),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // اسم العميل والموقع
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shimmerBox(width: 100),
                            SizedBox(height: 5.h),
                            shimmerBox(width: 150),
                          ],
                        ),
                      ],
                    ),
                    // Icons
                    Row(
                      children: [
                        shimmerCircle(),
                        SizedBox(width: 10.w),
                        shimmerCircle(),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // التفاصيل السفلية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اسم المنتج وكود الطلب
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(width: 120),
                      SizedBox(height: 5.h),
                      shimmerBox(width: 100),
                    ],
                  ),
                  // أزرار القبول والرفض
                  Row(
                    children: [
                      shimmerBox(width: 70, height: 25, radius: 7),
                      SizedBox(width: 5.w),
                      shimmerBox(width: 70, height: 25, radius: 7),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerCircle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
