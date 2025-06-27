import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';


class RowDropDown extends StatelessWidget {
  final Widget drop;
  final String title;
  const RowDropDown({super.key, required this.title, required this.drop});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGrey2
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8,bottom: 5,left: 8,right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: Styles.style4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(child: drop),
             SizedBox(width: 5.w),
          ],
        ),
      ),
    );
  }
}
