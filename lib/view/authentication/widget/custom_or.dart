import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

Widget CustomOR(){
  return Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: AppColors.whiteColor3,
                    thickness: 1,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    'او',
                    style: Styles.style1.copyWith(color: AppColors.lightGrey),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: AppColors.whiteColor3,
                    thickness: 1,
                  ),
                ),
              ],
            );
}