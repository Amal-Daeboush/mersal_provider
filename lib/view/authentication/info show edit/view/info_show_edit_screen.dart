import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/view/authentication/info%20show%20edit/widgets/tax_details_column.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_button_next.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import '../../file loading/view/file_loading_screen.dart';
import '../widgets/address_column.dart';
import '../widgets/bank_details_column.dart';
import '../widgets/work_details_column.dart';

class InfoShowEditScreen extends StatelessWidget {
  final String prov;
  const InfoShowEditScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: TextButton(
                onPressed: () => prov == 'service_provider'
                    ? Get.off(FileLoadingScreen(
                        prov: prov,
                      ))
                    : Get.off(BottomNavBarScreen(
                        prov: prov,
                      )),
                child: Text(
                  'x',
                  style: Styles.style3.copyWith(color: AppColors.black),
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Image.asset(
                AppImageAsset.logo,
                height: 25.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'قم بمراجعه التفاصيل الخاصه بك',
                  style: Styles.style6.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'تاكد جيدا قبل ان ترسل لنا كافه المعلومات المهمه',
                  style: Styles.style4.copyWith(color: AppColors.lightGrey),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //work details
                const WorkDetailsColumn(),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                const AddressColumn(),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                prov == 'service_provider'
                    ? const TaxDetailsColumn()
                    : const SizedBox(),
                prov == 'service_provider'
                    ? const Divider(
                        height: 3,
                        color: AppColors.whiteColor2,
                      )
                    : const SizedBox(),
                const BankDetailsColumn(),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: CustomButtonNext(
                      onTap: () => prov == 'service_provider'
                          ? Get.off(FileLoadingScreen(
                              prov: prov,
                            ))
                          : Get.off(
                              BottomNavBarScreen(
                                prov: prov,
                              ),
                            )),
                ),
              ],
            ),
          ),
        ));
  }
}
