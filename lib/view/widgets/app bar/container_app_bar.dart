import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors.dart';
import '../field search/custom_field_search.dart';

class ContainerAppBar extends StatelessWidget {
final  Widget? child;
final bool isSearch ;
  const ContainerAppBar({super.key, this.child, required this.isSearch});

  @override
  Widget build(BuildContext context) {
    return    Container(
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child!,
                SizedBox(
                  height: 20.h,
                ),
           isSearch?     const CustomFieldSearch(isorderScreen: false,height: 250,):SizedBox(),
              ],
            ),
          ),
        );
  }
}