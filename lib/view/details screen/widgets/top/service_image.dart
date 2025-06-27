  import 'package:flutter/material.dart';

import '../../../../core/constant/app_image_asset.dart';
import 'icon_image.dart';

Widget ServiceImage(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Container(color: Colors.grey[200]),
          Stack(
            children: [
              Image.asset(
                AppImageAsset.im2,
                width: screenWidth,
                height: screenHeight / 3,
                fit: BoxFit.cover,
              ),
               IconImage() 

            ],
          ),
        ],
      ),
    );
  }