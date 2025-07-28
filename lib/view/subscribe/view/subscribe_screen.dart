import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/subscribe/controller/subscribe_controller.dart';
import 'package:provider_mersal/view/subscribe/widgets/my_sub_card.dart';
import 'package:provider_mersal/view/subscribe/widgets/sub_dialog.dart';
import 'package:provider_mersal/view/subscribe/widgets/sub_shimmer.dart';
import 'package:provider_mersal/view/subscribe/widgets/subscribe_app_bar.dart';
import 'package:provider_mersal/view/subscribe/widgets/subscribe_card.dart';


import '../../../core/constant/app_colors.dart';

import '../../../core/constant/styles.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: HelperFunctions.screenHeight(),
                width: HelperFunctions.screenWidth(),
                child: Stack(
                  children: [
                    Container(color: Colors.grey[200]),
                    Container(
                      height: HelperFunctions.screenHeight() / 6,
                      color: AppColors.primaryColor,
                      child: const Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                        child: SubscribeAppBar(isSubscrib: true,),
                      ),
                    ),
                  ],
                ),
              ),

              GetBuilder(
                init: SubscribeController(),
                builder: (controller) {
                  return Positioned(
                    top: HelperFunctions.screenHeight() / 7,
                    child: Container(
                      height:
                          constraints.maxHeight -
                          (HelperFunctions.screenHeight() / 7),
                      width: HelperFunctions.screenWidth(),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            SizedBox(
                              height:
                                  constraints.maxHeight -
                                  (HelperFunctions.screenHeight() / 3.5),
                              child: ContainedTabBarView(
                                tabBarProperties: TabBarProperties(
                                  height: 40,
                                  padding: EdgeInsets.only(bottom: 10),
                                  indicatorWeight: 1,
                                  labelStyle: Styles.style5.copyWith(
                                    color: AppColors.black,
                                  ),
                                  unselectedLabelStyle: Styles.style5.copyWith(
                                    color: AppColors.black,
                                  ),
                                  indicatorColor: AppColors.primaryColor,
                                ),
                                tabs: const [
                                  Text('الاشتراكات '),
                                  Text('النشطه'),
                                  Text('المعلقة'),
                                  Text('المنتهية'),
                                ],
                                views: [
                                  controller.statusRequest ==
                                          StatusRequest.loading
                                      ? ListView.builder(
                                        itemBuilder:
                                            (context, index) =>
                                                SubShimmerCard(),
                                        itemCount: 5,
                                      )
                                      : controller.subcribes.isEmpty
                                      ? Center(child: Text('لا يوجد اشتراكات'))
                                      : ListView(
                                        children:
                                            controller.subcribes
                                                .map(
                                                  (e) => SubscribeCard(
                                                    onTap:
                                                        () => showSubscribeDialog(
                                                          context,
                                                          () {
                                                            controller
                                                                .addSubscribe(
                                                                  context,
                                                                  e.id.toString(),
                                                                );
                                                          },
                                                        ),
                                                    subscribeModel: e,
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                  FutureBuilder(
                                    future: controller.getMySubcribes("active"),
                                    builder: (context, snapshot) {
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          // فرض التحديث
                                          controller.hasFetchedActive = false;
                                          await controller.getMySubcribes(
                                            "active",
                                          );
                                        },
                                        child:
                                            controller.activeSubscribes.isEmpty
                                                ? ListView(
                                                  // لازم ListView داخل RefreshIndicator حتى لو فارغ
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        ' لا يوجد طلبات نشطة',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                : ListView(
                                                  children:
                                                      controller
                                                          .activeSubscribes
                                                          .map(
                                                            (e) => MySubCard(
                                                              subscribeModel: e,
                                                            ),
                                                          )
                                                          .toList(),
                                                ),
                                      );
                                    },
                                  ),

                                  // 3. المعلقة
                                  FutureBuilder(
                                    future: controller.getMySubcribes(
                                      "pending",
                                    ),
                                    builder: (context, snapshot) {
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          controller.hasFetchedPending = false;
                                          await controller.getMySubcribes(
                                            "pending",
                                          );
                                        },
                                        child:
                                            controller.pendingSubscribes.isEmpty
                                                ? ListView(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        ' لا يوجد طلبات معلقة',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                : ListView(
                                                  children:
                                                      controller
                                                          .pendingSubscribes
                                                          .map(
                                                            (e) => MySubCard(
                                                              subscribeModel: e,
                                                            ),
                                                          )
                                                          .toList(),
                                                ),
                                      );
                                    },
                                  ),

                                  // 4. المنتهية
                                  FutureBuilder(
                                    future: controller.getMySubcribes(
                                      "finished",
                                    ),
                                    builder: (context, snapshot) {
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          controller.hasFetchedFinished = false;
                                          await controller.getMySubcribes(
                                            "finished",
                                          );
                                        },
                                        child:
                                            controller
                                                    .finishedSubscribes
                                                    .isEmpty
                                                ? ListView(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        ' لا يوجد طلبات منتهية',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                : ListView(
                                                  children:
                                                      controller
                                                          .finishedSubscribes
                                                          .map(
                                                            (e) => MySubCard(
                                                              subscribeModel: e,
                                                            ),
                                                          )
                                                          .toList(),
                                                ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
