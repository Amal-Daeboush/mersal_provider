import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class SubscribeAppBar extends StatelessWidget {
  final bool isSubscrib;
  const SubscribeAppBar({super.key, required this.isSubscrib});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Image.asset(
                 AppImageAsset.logo,
                 height: 25.h,
                 fit: BoxFit.cover,
               ),
                Text(
            isSubscrib?      'الاشتراكات':'اصناف اطباقي',
                  style: Styles.style6.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                ),
              IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.arrow_forward_ios,color: AppColors.whiteColor,)),
            //   NotificationIcon(isHomeScreen: false,)
              ],
            );
  }
}