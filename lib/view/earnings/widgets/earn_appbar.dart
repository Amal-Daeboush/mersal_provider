import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/widgets/icons/arrow_back_icon.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class EarnAppbar extends StatelessWidget {
  const EarnAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage(AppImageAsset.profile),
        ),
        Text(
          'أرباحك الحالية',
          style: Styles.style6.copyWith(
              color: AppColors.whiteColor, fontWeight: FontWeight.w500),
        ),
        ArrowBackIcon(
          isHomeScreen: false,
          onTap: () => Get.back(),
        )
      ],
    );
  }
}
