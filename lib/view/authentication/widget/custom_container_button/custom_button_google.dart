import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_container_button.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CustomButtonGoogle extends StatelessWidget {
  final bool isGoogle;
final void Function()? onTap;
  const CustomButtonGoogle({super.key, required this.isGoogle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainerButton(
      onTap:onTap ,
      borderColor: AppColors.whiteColor2,
      color: AppColors.whiteColor2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isGoogle
              ? Image.asset(AppImageAsset.google)
              : Icon(
                  Icons.facebook,
                  color: Colors.blue,
                ),
                SizedBox(width: 60.w,),
          Text(isGoogle ? 'تسجيل الدخول عبر جوجل' : 'تسجيل الدخول عبر فيسبوك ',
              style: Styles.style1.copyWith(color: Colors.black,fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
