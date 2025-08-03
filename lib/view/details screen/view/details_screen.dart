import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';

import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/details%20screen/controller/details_controller.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../widgets/details/details_service.dart';
import '../widgets/tap bar/custom_tab_bar.dart';
import '../widgets/top/service_image.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const DetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder(
        init: DetailsController(id: productModel.id),
        builder: (controller) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    ServiceImage(
                      screenWidth,
                      screenHeight,
                      productModel.images.first.url,
                    ),
                    // details
                    Positioned(
                      top: screenHeight / 3.5,
                      child: Container(
                        width: screenWidth,
                        height: constraints.maxHeight - (screenHeight / 3.5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DetailsService(productModel: productModel),

                                    //
                                    // tab bar
                                    controller.statusRequest ==
                                            StatusRequest.loading
                                        ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 130.w,
                                              vertical: 15.h,
                                            ),
                                            child: customLoadingIndictor(),
                                          ),
                                        )
                                        : controller.statusRequest ==
                                            StatusRequest.failure
                                        ? CustomTabBar(
                                          images: productModel.images,
                                          message: controller.message,
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        )
                                        : controller.statusRequest ==
                                            StatusRequest.offlineFailure
                                        ? CustomTabBar(
                                          images: productModel.images,
                                          message: controller.message,
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        )
                                        : CustomTabBar(
                                          images: productModel.images,
                                          ratings: controller.ratings,
                                          height: constraints.maxHeight / 2.5,
                                        ),
                                  ],
                                ),
                              ),
                            ),

                            //button
                            // orderButton()
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
