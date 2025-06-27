import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xffFBFBFB);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color black2 = Color(0xff121111);
  static const Color primaryColor = Color(0xff7246A7);
    static  Color primaryColorWithOpacity  = Color(0xff7246A7).withOpacity(0.1);
        static  Color primaryColorWithOpacity2  = Color(0xff7246A7).withOpacity(0.06);
  static const Color primaryColorBold = Color(0xff282A5B);
  static const Color whiteColor = Color(0xffffffff);
  static Color whiteColorWithOpacity =const Color(0xffffffff).withOpacity(0.2);
    static Color whiteColorWithOpacity2 =const Color(0xffffffff).withOpacity(0.42);
  static const Color whiteColor2 = Color(0xffF4F5F7);
  static const Color whiteColor3 = Color(0xffF0F0F0);
  static const Color charcoalGrey = Color(0xff172B4D);
  static const Color greyColor = Color(0xff596373);
    static const Color greyColor2 = Color(0xffD4D4D4);
       static const Color greyColor3= Color(0xff787676);
            static const Color greyColor4= Color(0xff959595);
  static const Color lightGrey = Color(0xff7A869A);
 static const Color lightGrey3 = Color(0xffC1C7D0);
  static const Color red = Color(0xffC20003);
  static const Color lightGrey2 = Color(0xffF1F1F1);
   static const Color border = Color(0xffBABABA);
/*   static const grayLinearGradiant = LinearGradient(colors :[lightGrey, greyColor7],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  ); */
/* 
  static const blueLinearGradiant = LinearGradient(colors: [primaryColor, lightBlue],
  begin: Alignment.topLeft,
    end: Alignment.bottomRight
  ); */
    static const greyShadow = BoxShadow(
    color: border,
    offset: Offset(0, 5),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const Color startLinearTextColor = Color(0xff2364C6);
  static const Color endLinearTextColor = Color(0xffACBFDA);
  static const textGradient = LinearGradient(
      colors: [AppColors.startLinearTextColor, AppColors.endLinearTextColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const buttonGradient = LinearGradient(
      colors: [AppColors.primaryColor, charcoalGrey],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
