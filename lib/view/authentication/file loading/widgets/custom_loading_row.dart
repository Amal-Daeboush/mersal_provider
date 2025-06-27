import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CustomLoadingRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;
  const CustomLoadingRow({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey2,
          borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor.withOpacity(0.7)),
                SizedBox(width: 5),
                Text(title, style: Styles.style1),
              ],
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
