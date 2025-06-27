import 'package:flutter/material.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';

import '../../../../core/constant/styles.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String info;
  const CustomRow({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
       /*  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, */
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Styles.style5.copyWith(color: AppColors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              info,
              textAlign: TextAlign.start,
              style: Styles.style5.copyWith(color: AppColors.lightGrey),
            ),
          )
        ],
      ),
    );
  }
}
