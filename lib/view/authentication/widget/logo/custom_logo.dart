import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import '../../../../core/constant/app_image_asset.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return      Container(
              decoration:  BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff7246A7).withOpacity(0.08)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Image.asset(AppImageAsset.logo,height: 55.h,width: 80,),
                    Text('مرسال',style: Styles.style2,)
                  ],
                ),
              ),
            );
  }
}