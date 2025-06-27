import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/model/notification_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notification.isRead?AppColors.whiteColor:AppColors.primaryColorWithOpacity2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage(AppImageAsset.notif_image),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    notification.text,
                    style: Styles.style1
                        .copyWith(color: AppColors.primaryColorBold),
                  ),
                )),
                Text(
                  '2 min',
                  style: Styles.style4.copyWith(color: AppColors.greyColor),
                )
              ],
            ),
              SizedBox(
                  height: 10.w,
                ),
            notification.status == 'rate'
                ? Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                            child: Text(
                              'رد',
                              style: Styles.style5
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.lightGrey),
                              color: AppColors.whiteColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Text('اعجاب',
                                style: Styles.style5
                                    .copyWith(color: AppColors.primaryColor)),
                          ),
                        ),
                      ],
                    ),
                )
                : Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            child: Text(
                              'قبول',
                              style: Styles.style5
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.lightGrey),
                              color: AppColors.whiteColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10
                            ,vertical: 3),
                            child: Text('رفض',
                                style: Styles.style5
                                    .copyWith(color: AppColors.primaryColor)),
                          ),
                        ),
                      ],
                    ),
                )
          ],
        ),
      ),
    );
  }
}
