import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class CustomSmallBut extends StatelessWidget {
  final void Function()? onTap;
  final Icon icon;
  const CustomSmallBut({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(padding: const EdgeInsets.all(4), child: icon),
      ),
    );
  }
}
