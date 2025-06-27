import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/view/authentication/widget/custom_container_button/custom_button_next.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../../core/constant/styles.dart';
import '../widgets/custom_loading_row.dart';

class FileLoadingScreen extends StatelessWidget {
  final String prov;
  const FileLoadingScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: TextButton(
                onPressed: () => Get.off(BottomNavBarScreen(prov: prov)),
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
                  'تحميل الملفات',
                  style: Styles.style6.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'يرجى تحميل المستندات التاليه لضمان قدرتك على العمل على مرسال دون اى متاعب من الناحيه القانونيه',
                  style: Styles.style4.copyWith(color: AppColors.lightGrey),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const CustomLoadingRow(
                  title: 'السجل التجارى',
                  icon: Iconsax.receipt_text,
                ),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                const CustomLoadingRow(
                  title: 'الضريبه',
                  icon: Iconsax.clipboard_text,
                ),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                const CustomLoadingRow(
                  title: 'شهاده ضريبه القيمه المضافه',
                  icon: Iconsax.document_text_1,
                ),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                const CustomLoadingRow(
                  title: 'تحميل اثبات الهويه',
                  icon: Iconsax.personalcard,
                ),
                const Divider(
                  height: 3,
                  color: AppColors.whiteColor2,
                ),
                const CustomLoadingRow(
                  title: 'تحميل شعار العلامه التجاريه',
                  icon: Iconsax.gallery_export,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButtonNext(
                    onTap: () => Get.off(BottomNavBarScreen(prov: prov)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
