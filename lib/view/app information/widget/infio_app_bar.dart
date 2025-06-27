import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/app bar/container_app_bar.dart';

class InfioAppBar extends StatelessWidget {
  const InfioAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerAppBar(
      isSearch: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Iconsax.login, color: AppColors.whiteColor,size: 20,)),
            Text(
              'عن التطبيق',
              style: Styles.style6.copyWith(color: AppColors.whiteColor,fontWeight: FontWeight.w500),
            ),
            IconButton(
                onPressed: () {Get.back();},
                icon:
                    Icon(Icons.arrow_forward_ios, color: AppColors.whiteColor,size: 20,)),
          ],
        ),
      ),
    );
  }
}
