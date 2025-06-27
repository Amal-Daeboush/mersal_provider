import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';
import 'custom_container_button.dart';

class CustomButtonNext extends StatelessWidget {
  final void Function()? onTap;
  const CustomButtonNext({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainerButton(
      onTap: onTap,
      borderColor: AppColors.primaryColor,
      color: AppColors.primaryColor,
      child: Text(
        'التالي',
        style: Styles.style1.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}
