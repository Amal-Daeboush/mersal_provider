import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

Widget CustomTitleRow(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: Styles.style1,
      ),
      IconButton(
          onPressed: () {},
          icon:
              Icon(Icons.border_color_outlined, size: 15,color: AppColors.primaryColor))
    ],
  );
}
