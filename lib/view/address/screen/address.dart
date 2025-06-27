/* import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_container_button.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_sizes.dart';
import '../../../core/constant/styles.dart';
import '../../authentication/bank details/view/bank_details_screen.dart';
import '../../authentication/tax screen/view/tax_screen.dart';
import '../../widgets/loading/custom_loading.dart';
import '../controller/address_controller.dart';


class AddressScreen extends StatelessWidget {
  final String provider;
  const AddressScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController(provider: provider));
    return Scaffold(
      body: GetBuilder<AddressController>(builder: (controller) {
        return HandlingDataView(
          onRefresh: () async {
            controller.onRefresh();
          },
          statusRequest: controller.statusRequest,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  ' عنوان التوصيل',
                  style: Styles.style1,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 8, 10),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greyColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'ابحث عن موقعك',
                        hintStyle: Styles.style4,
                        prefixIcon: const Icon(
                          Iconsax.search_normal,
                          size: 15,
                          color: AppColors.greyColor,
                        ),
                        //     prefix: Icon(Iconsax.search_favorite)),
                      )),
                ),
              ),

              GetBuilder<AddressController>(
                builder: (controller) {
                  return SizedBox(
                    height: HelperFunctions.screenHeight() / 1.75,
                    child: controller.kGooglePlex != null
                        ? GoogleMap(
                            markers: controller.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: controller.kGooglePlex!,
                            onMapCreated: (GoogleMapController mapController) {
                              if (!controller.completerController.isCompleted) {
                                controller.completerController
                                    .complete(mapController);
                              }
                            },
                          )
                        : const Center(
                            child: CustomLoading(
                              color: AppColors.primaryColor,
                            ),
                          ),
                  );
                },
              ),
              //  Size const AddressActionSection()
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  SvgPicture.asset(
                    AppImageAsset.ic_pin_Primary,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(controller.currentCity ?? 'حار تحميل موقعك')
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: CustomContainerButton(
                    onTap: () => provider == 'product_provider'
                        ? Get.off(BankDetailsScreen(prov: provider,))
                        : Get.off(TaxScreen(prov: provider,)),
                    borderColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        'اكد موقعك',
                        style:
                            Styles.style1.copyWith(color: AppColors.whiteColor),
                      ),
                    )),
              )
            ],
          ),
        );
      }),
    );
  }
}
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/address/widget/address_text_field.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_container_button.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/loading/custom_loading.dart';
import '../controller/address_controller.dart';

class AddressScreen extends StatelessWidget {
  final bool isfromHome;

  const AddressScreen({super.key, required this.isfromHome});

  @override
  Widget build(BuildContext context) {
    // Get.put(AddressController(isHome: isfromHome));
    return Scaffold(
      body: GetBuilder<AddressController>(
        init: AddressController(isHome: isfromHome,context),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(' عنوان التوصيل', style: Styles.style1),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 8, 10),
                  child: AddressTextFiled(
                    hint: 'ابحث عن موقعك',

                    //  controller: controller.addressController,
                    prefixIcon: const Icon(
                      Iconsax.search_normal,
                      size: 15,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),

                GetBuilder<AddressController>(
                  builder: (controller) {
                    return SizedBox(
                      height: HelperFunctions.screenHeight() / 2,
                      child:
                          controller.kGooglePlex != null
                              ? GoogleMap(
                                markers: controller.markers,
                                mapType: MapType.normal,
                                initialCameraPosition: controller.kGooglePlex!,
                                onMapCreated: (
                                  GoogleMapController mapController,
                                ) {
                                  if (!controller
                                      .completerController
                                      .isCompleted) {
                                    controller.completerController.complete(
                                      mapController,
                                    );
                                  }
                                },
                              )
                              : const Center(
                                child: CustomLoading(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                    );
                  },
                ),
                //  Size const AddressActionSection()
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImageAsset.ic_pin_Primary),
                          SizedBox(width: 10.w),
                          Text(controller.currentCity ?? 'حار تحميل موقعك'),
                        ],
                      ),
                      Form(
                        key: controller.keyForm,
                        child: AddressTextFiled(
                          hint: 'ادخل عنوانك',
                          validator: (p0) => controller.validate(p0),
                          controller: controller.addressController,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CustomContainerButton(
                    onTap: () {
                      controller.isfoundProfile?
                      controller.updateAddress():
                      controller.storeProfile();
                      // Get.back();
                    },

                    //      Get.offAll(BottomNavBarScreen());
                    borderColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                    child: Center(
                      child:
                          controller.statusRequestAddress ==
                                  StatusRequest.loading
                              ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  //vertical: 100,
                                ),
                                child: Center(child: CircularProgressIndicator()),
                              )
                              : Text(
                                'اكد موقعك',
                                style: Styles.style1.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
