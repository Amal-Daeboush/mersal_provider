import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/earnings/view/earning_screen.dart';


import '../../../core/constant/app_colors.dart';

class EarnIcon extends StatelessWidget {
  final bool isHomeScreen;
  final void Function() onTap;
  const EarnIcon({super.key, required this.isHomeScreen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
                      decoration: BoxDecoration(
                      //  border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color:isHomeScreen? AppColors.primaryColorWithOpacity2:AppColors.whiteColorWithOpacity),
                      child:  Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                        //  Iconsax.notification,
                        AppImageAsset.increase,height: 20,
                         // size: 20,
                          color:isHomeScreen? AppColors.primaryColor:AppColors.whiteColor,
                        ),
                      ),
                    ),
    );
  }
}