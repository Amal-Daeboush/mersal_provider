import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/notifications%20screen/controller/notification_controller.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: HelperFunctions.screenHeight(),
            width: HelperFunctions.screenWidth(),
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                ),
                Container(
                  height: HelperFunctions.screenHeight() / 6,
                  color: AppColors.primaryColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage:
                                const AssetImage(AppImageAsset.profile),
                          ),
                         Image.asset(
                           AppImageAsset.logo,
                           height: 25.h,
                           fit: BoxFit.cover,
                         ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Positioned(
              top: HelperFunctions.screenHeight() / 7,
              child: Container(
                  height: constraints.maxHeight -
                      (HelperFunctions.screenHeight() / 7),
                  width: HelperFunctions.screenWidth(),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppImageAsset.handel),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الاشعارات',
                                style: Styles.style6.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColorBold),
                              ),
                              const Icon(Icons.done_all,
                                  color: AppColors.primaryColorBold)
                            ],
                          ),
                        ),
                        /*   SizedBox(
              height: 10.h,
            ), */
                        GetBuilder(
                            init: NotificationController(),
                            builder: (controller) {
                              return controller.notification.isEmpty
                                  ? Center(
                                      child: Text(
                                        'لا يوجد اشعارات',
                                        style: Styles.style1.copyWith(
                                            color: AppColors.primaryColor),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.separated(
                                      itemCount: controller.notification.length,
                                      itemBuilder: (context, index) =>
                                          NotificationCard(
                                        notification:
                                            controller.notification[index],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        height: 2,
                                        color: AppColors.whiteColor3,
                                      ),
                                    ));
                            })
                      ],
                    ),
                  )))
        ],
      );
    }));
  }
}
