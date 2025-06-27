import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class Styles {
  static TextStyle style1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle style1_copy1 = style1.copyWith(
      color: AppColors.primaryColorBold, fontWeight: FontWeight.w600);
  static TextStyle style2 = TextStyle(
    color: AppColors.black,
    fontSize: 30.sp,
     fontFamily: 'Cairo',
    fontWeight: FontWeight.w400,
  );
  static TextStyle style3 = TextStyle(
    color: AppColors.charcoalGrey,
    fontSize: 22.sp,  fontFamily: 'Cairo',
    fontWeight: FontWeight.w400,
  );
  static TextStyle style1_copy2 =
      
      style1.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w400);
      
  static TextStyle style4 = TextStyle(
    fontSize: 12.sp,
    height: 0,  fontFamily: 'Cairo',
    fontWeight: FontWeight.w400,
  );
  static TextStyle style5 = TextStyle(
    fontSize: 10.sp,
    height: 0,  fontFamily: 'Cairo',
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle style8 = TextStyle(
    fontSize: 8.sp,
    height: 0,  fontFamily: 'Cairo',
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static TextStyle style6 = TextStyle(
    fontSize: 16.sp,
     fontFamily: 'Cairo',
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle style18 = TextStyle(
    color: AppColors.backgroundColor,
    fontSize: 18.sp,
  fontFamily: 'Cairo',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static TextStyle styleLight18 = TextStyle(
    color: AppColors.greyColor,
    fontSize: 18.sp,
     fontFamily: 'Cairo',
    fontWeight: FontWeight.w300,
    height: 0,
  );

  static TextStyle style12 = TextStyle(
    color: AppColors.lightGrey,
    fontSize: 12.sp,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  
  static TextStyle style20 = TextStyle(
   
    fontSize: 20.sp,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
    height: 0,
  );
}
