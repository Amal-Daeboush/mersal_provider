  import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';

Widget IconImage() {
    return Positioned(
      left: 10,
      top: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIcon(Icons.arrow_forward_ios, AppColors.whiteColorWithOpacity2,()=>Get.back()),
    //      const SizedBox(width: 8),
     //     _buildIcon(Icons.shopping_cart_outlined, AppColors.whiteColorWithOpacity2),
        ],
      ),
    );
  }

  //build icon  Widget _buildIcon(IconData icon, Color color) {

Widget _buildIcon(IconData icon, Color color,void Function()? onTap) {
    return InkWell(
       focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap:onTap ,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: color,
        ),
        child: Icon(icon, size: 17, color: AppColors.whiteColor),
      ),
    );
  }