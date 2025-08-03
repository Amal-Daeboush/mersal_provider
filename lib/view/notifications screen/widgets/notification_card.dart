import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/notification_model.dart';

import '../../../core/class/helper_functions.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: HelperFunctions.screenWidth(),
      color:
          notificationModel.status == 'pending'
              ? AppColors.whiteColor3
              : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage(AppImageAsset.notif_image),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  notificationModel.notification!,
                  style: Styles.style1.copyWith(
                    color: AppColors.primaryColorBold,
                  ),
                ),
              ),
            ),
            Text(
              '2 min',
              style: Styles.style4.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
      ),
    );
  }
}
