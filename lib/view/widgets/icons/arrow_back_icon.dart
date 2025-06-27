import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';

class ArrowBackIcon extends StatelessWidget {
  final void Function()? onTap;
  final bool isHomeScreen;
  const ArrowBackIcon({super.key, required this.isHomeScreen, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
       focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
            //  border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(7),
            color: isHomeScreen
                ? AppColors.primaryColorWithOpacity2
                : AppColors.whiteColorWithOpacity),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: isHomeScreen ? AppColors.primaryColor : AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
