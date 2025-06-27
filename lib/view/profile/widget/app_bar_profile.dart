import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/constant/const_data.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
              decoration:const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        20,
                      ),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10,top: 15,bottom: 15,right: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20.r,
                    backgroundImage: AssetImage(AppImageAsset.profile),
                  ),
                  title: Text(
                    ConstData.user!.user.name,
                    style: Styles.style1
                        .copyWith(color: AppColors.primaryColorBold),
                  ),
                  trailing:  Image.asset(
                    AppImageAsset.logo,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
  }
}