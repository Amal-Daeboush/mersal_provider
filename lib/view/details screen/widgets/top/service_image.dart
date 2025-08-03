  import 'package:flutter/material.dart';
import 'icon_image.dart';

Widget ServiceImage(double screenWidth, double screenHeight,String url) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Container(color: Colors.grey[200]),
          Stack(
            children: [
              Image.network(
             url,
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