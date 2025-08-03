import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class MyOrdersAppBar extends StatelessWidget {
  const MyOrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               CircleAvatar(
            radius: 20.r,
            backgroundImage:
                ConstData.image.isEmpty
                    ? const AssetImage(AppImageAsset.user)
                    : NetworkImage(ConstData.image) as ImageProvider,
          ),
                Text(
                  'الطلبات',
                  style: Styles.style6.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                ),
               Image.asset(
                 AppImageAsset.logo,
                 height: 25.h,
                 fit: BoxFit.cover,
               ),
            //   NotificationIcon(isHomeScreen: false,)
              ],
            );
  }
}