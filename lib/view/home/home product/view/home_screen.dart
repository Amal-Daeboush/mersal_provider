import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/view/home/home%20product/controller/home_product_controller.dart';
import 'package:provider_mersal/view/home/widgets/card/card_product.dart';
import 'package:provider_mersal/view/home/widgets/card_row.dart';
import 'package:provider_mersal/view/home/widgets/product_shimmer.dart';
import 'package:provider_mersal/view/order/widget/order_shimmer.dart';
import 'package:provider_mersal/view/order/widget/sp_order_card.dart';
import 'package:provider_mersal/view/product/add%20product/view/add_product_screen.dart';
import 'package:provider_mersal/view/product/edit%20product/view/edit_product_screen.dart';
import 'package:provider_mersal/view/product/refresh%20product/view/refresh_product_screen.dart';
import '../../../../core/class/helper_functions.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../details screen/view/details_screen.dart';
import '../../../earnings/view/earning_screen.dart';
import '../../../widgets/field search/custom_field_search.dart';
import '../../widgets/card/order_card.dart';
import '../../widgets/discount/discount_card.dart';
import '../../widgets/title row/add_product_row.dart';
import '../../widgets/title row/recent_orders_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isfood = ConstData.user!.user.type == 'food_provider';
    HomeProductController homecontroller = Get.put(HomeProductController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: ListTile(
          title: Text(
            'مرحبا 👋',
            style: Styles.style1.copyWith(color: AppColors.greyColor3),
          ),
          subtitle: Text(
            ConstData.user!.user.name??'',
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
        init: HomeProductController(),
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
                    add: () => Get.to(const AddProductScreen()),
                    isSrervice: false,
                    isfood:isfood
                  ),
                  SizedBox(height: 15.h),
                  controller.statusRequest == StatusRequest.loading
                      ? SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProductCardShimmer(),
                        ),
                      )
                      : controller.products.isEmpty
                      ? Center(
                        child: Text(
                          isfood
                              ? 'ليس لديك اطباق طعام بعد قم باضافة طعام.'
                              : 'ليس لديك منتجات بعد قم باضافة منتج.',
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
                              (context, index) => CardProduct(
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
                                      isfood
                                          ? 'هل انت متأكد من حذف الطعام '
                                          : 'هل انت متأكد من حذف المنتج ',
                                      style: Styles.style1,
                                    ),
                                  );
                                },
                                productModel: controller.products[index],
                                ontap:
                                    () => Get.to(
                                      DetailsScreen(
                                        productModel:
                                            controller.products[index],
                                      ),
                                    ),
                                edit:
                                    () => Get.to(
                                      EditProductScreen(
                                        productModel:
                                            controller.products[index],
                                      ),
                                    ),
                                refresh:
                                    () => Get.to(const RefreshProductScreen()),
                                isProductCard: true,
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
                      : controller.orders.isEmpty
                      ? Center(
                        child: Text(
                          'ليس لديك  طلبات بعد .',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: controller.orders.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        //  scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) =>
                                OrderCard2(order: controller.orders[index]),
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
