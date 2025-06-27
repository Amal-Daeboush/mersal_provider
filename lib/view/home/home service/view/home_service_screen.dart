import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/view/details%20screen/view/details_screen.dart';
import 'package:provider_mersal/view/earnings/view/earning_screen.dart';
import 'package:provider_mersal/view/home/home%20service/controller/home_services_controller.dart';
import 'package:provider_mersal/view/home/widgets/card/card_product.dart';
import 'package:provider_mersal/view/home/widgets/card/card_services.dart';
import 'package:provider_mersal/view/home/widgets/card_row.dart';
import 'package:provider_mersal/view/home/widgets/product_shimmer.dart';
import 'package:provider_mersal/view/order/widget/order_shimmer.dart';
import 'package:provider_mersal/view/order/widget/reservation_card.dart';
import 'package:provider_mersal/view/service/add%20service/view/add_service_screen.dart';
import 'package:provider_mersal/view/service/edit%20%20service/view/edit_service_screen.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../../../../core/class/helper_functions.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../widgets/card/order_card.dart';
import '../../widgets/discount/discount_card.dart';
import '../../widgets/title row/add_product_row.dart';
import '../../widgets/title row/recent_orders_row.dart';
import '../../../widgets/field search/custom_field_search.dart';

class HomeServiceScreen extends StatelessWidget {
  const HomeServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeServicesController homecontroller = Get.put(HomeServicesController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: ListTile(
          title: Text(
            'مرحبا 👋',
            style: Styles.style1.copyWith(color: AppColors.greyColor3),
          ),
          subtitle: Text(
            ConstData.user!.user.name ?? '',
            style: Styles.style6.copyWith(color: AppColors.black2),
          ),
          trailing: Image.asset(
            AppImageAsset.logo,
            height: 25.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: GetBuilder(
        init: HomeServicesController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFieldSearch(
                    height: HelperFunctions.screenWidth(),
                    isorderScreen: false,
                  ),
                  SizedBox(height: 15.h),
                  InkWell(
                    onTap: () => Get.to(const EarningScreen()),
                    child: CardRow(
                      ordersCounts: controller.orders.length.toString(),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const DiscountCard(),
                  SizedBox(height: 15.h),
                  AddRow(
                    isfood: false,
                    isSrervice: true,
                    add: () => Get.to(const AddServiceScreen()),
                  ),
                  SizedBox(height: 15.h),
                  controller.statusRequest == StatusRequest.loading
                      ? SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProductCardShimmer(),
                        ),
                      )
                      : controller.products.isEmpty
                      ? const Center(
                        child: Text(
                          'ليس لديك خدمات بعد قم باضافة خدمة.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:
                              (context, index) => CardServices(
                                delete: () {
                                  Get.defaultDialog(
                                    title: '',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            'لا',
                                            style: Styles.style4,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.deleteProduct(
                                            controller.products[index].id
                                                .toString(),
                                          );
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            'نعم',
                                            style: Styles.style4.copyWith(
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    content: Text(
                                      'هل انت متأكد من حذف الخدمة ',
                                      style: Styles.style1,
                                    ),
                                  );
                                },
                                serviceModel: controller.products[index],
                                ontap:
                                    () => Get.to(
                                      DetailsScreen(
                                        productModel:
                                            controller.products[index],
                                      ),
                                    ),
                                edit:
                                    () => Get.to(
                                      EditServiceScreen(
                                        productModel:
                                            controller.products[index],
                                      ),
                                    ),

                                isProductCard: false,
                              ),
                        ),
                      ),
                  const RecentOrdersRow(),
                  controller.statusRequestOrders == StatusRequest.loading
                      ? ListView.builder(
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        //  scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => const ReservationCardShimmer(),
                      )
                      : controller.reservcation.isEmpty
                      ? Center(
                        child: Text(
                          'ليس لديك  حجوزات بعد .',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: controller.reservcation.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        //  scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => ReservationCard(
                              order: controller.reservcation[index],
                            ),
                      ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
