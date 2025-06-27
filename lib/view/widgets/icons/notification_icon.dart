import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/view/notifications%20screen/view/notification_screen.dart';

import '../../../core/constant/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final bool isHomeScreen;
  const NotificationIcon({super.key, required this.isHomeScreen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(NotificationScreen()),
      child: Container(
                      decoration: BoxDecoration(
                      //  border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color:isHomeScreen? AppColors.primaryColorWithOpacity2:AppColors.whiteColorWithOpacity),
                      child:  Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Iconsax.notification,
                          size: 20,
                          color:isHomeScreen? AppColors.primaryColor:AppColors.whiteColor,
                        ),
                      ),
                    ),
    );
  }
}