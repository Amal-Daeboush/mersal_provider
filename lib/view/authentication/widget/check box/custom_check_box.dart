import 'package:flutter/material.dart';


import 'package:provider_mersal/core/constant/app_colors.dart';

import '../../../../core/constant/styles.dart';

  Widget buildCheckBox(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color:  AppColors.primaryColorBold ,
           width: 0.5
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: isSelected
                ? const Center(
                  child: Icon(
                      Icons.check_rounded,
                      color: AppColors.primaryColor,
                      size: 15,
                    ),
                )
                : null,
          ),
          const SizedBox(width: 10),
          Text(label, style: Styles.style4.copyWith(color: AppColors.black),),
        ],
      ),
    );
  }