import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/order_model.dart';
import 'package:provider_mersal/model/reservation_model.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:provider_mersal/view/order/widget/order_shimmer.dart';
import 'package:provider_mersal/view/order/widget/reservation_card.dart';
import '../../../core/class/helper_functions.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/field search/custom_field_search.dart';
import '../controller/order_controller.dart';
import '../widget/my_orders_app_bar.dart';
import '../widget/sp_order_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: MyOrdersAppBar(),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder(
                init: OrderController(),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFieldSearch(
                                height: 250.w,
                                isorderScreen: true,
                              ),
                            ),
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
                                tabs: [
                                  Text('جميع الطلبات'),
                                  //   Text('النشطه'),
                                  //  Text('المكتمله'),
                                  Text('الملغاه'),
                                  Text('المقبولة'),
                                  if (ConstData.producter) Text('قيد التوصيل'),
                                  Text('المنتظره'),
                                ],
                                views:
                                    ConstData.producter
                                        ? [
                                          // مقدم خدمة: عرض الطلبات
                                          buildOrderList(
                                            controller.orders,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                          ),
                                          buildOrderList(
                                            controller.cancelOrders,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                          ),
                                          buildOrderList(
                                            controller.acceptOrders,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                          ),
                                          buildOrderList(
                                            controller.onWayOrders,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                          ),
                                          buildOrderList(
                                            controller.waitOrders,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                          ),
                                        ]
                                        : [
                                          // مستخدم: عرض الحجوزات
                                          buildReservationList(
                                            controller.reservcation,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                            controller,
                                          ),
                                          buildReservationList(
                                            controller.cancelReservation,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                            controller,
                                          ),
                                          buildReservationList(
                                            controller.acceptReservation,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                            controller,
                                          ),
                                          buildReservationList(
                                            controller.waitReservation,
                                            controller.statusRequest ==
                                                StatusRequest.loading,
                                            controller,
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

  Widget buildOrderList(List<OrderModel> orders, bool isloading) {
    if (isloading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ReservationCardShimmer(),
      );
    }
    return orders.isNotEmpty
        ? ListView(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) => OrderCard2(order: orders[index]),
            ),
            const SizedBox(height: 20),
          ],
        )
        : Center(child: Text('لا يوجد طلبات'));
  }

  Widget buildReservationList(
    List<ReservationModel> reservations,
    bool isloading,
    OrderController controller,
  ) {
    if (isloading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ReservationCardShimmer(),
      );
    }

    return reservations.isNotEmpty
        ? ListView(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reservations.length,
              itemBuilder:
                  (context, index) => ReservationCard(
                    order: reservations[index],
                    orderController: controller,
                  ),
            ),
            const SizedBox(height: 20),
          ],
        )
        : Center(child: Text('لا توجد حجوزات'));
  }
}
