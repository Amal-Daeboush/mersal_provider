import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/model/commission_model.dart';
import 'package:provider_mersal/view/earnings/controller/earn_controller.dart';
import 'package:provider_mersal/view/widgets/field%20search/custom_field_search.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';
import '../../widgets/custom_button_service.dart/service_button.dart';
import '../widgets/earn_appbar.dart';
import '../widgets/earn_row.dart';
import '../widgets/earn_row_card.dart';

class EarningScreen extends StatelessWidget {
  final CommiessionModel? commiessionModel;
  final String totalPending ;
 final String totalCompleted ;
  const EarningScreen({super.key, this.commiessionModel, required this.totalPending, required this.totalCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor3,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GetBuilder<EarnController>(
            init: EarnController(),
            builder: (controller) {
              return SafeArea(
                child: Column(
                  children: [
                    /// ✅ **الشريط العلوي (AppBar)**
                    Container(
                      height: HelperFunctions.screenHeight() / 6,
                      color: AppColors.primaryColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: EarnAppbar(),
                      ),
                    ),

                    /// ✅ **قسم المعلومات الأساسية**
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: EarnRowCard(
                        total:
                            commiessionModel?.totalSales
                                .toString() ??
                            '',
                        pending: totalPending,
                        completed: totalCompleted,
                      ),
                    ),

                    /// ✅ **القسم السفلي مع توسيع تلقائي**
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              controller.statusRequest == StatusRequest.loading
                                  ? Center(
                                    child: Text(
                                      'جار جلب الارباح ',
                                      style: Styles.style1.copyWith(
                                        color: AppColors.primaryColorBold,
                                      ),
                                    ),
                                  )
                                  : Column(
                                    children: [
                                      /// ✅ **العنوان و البحث**
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'تفاصيل المدفوعات',
                                                  style: Styles.style1.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                            /*     const CustomFieldSearch(
                                                  isorderScreen: false,
                                                  height: 150,
                                                ), */
                                              ],
                                            ),
                                            SizedBox(height: 15.h),

                                            /// ✅ **العناوين العلوية**
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'تاريخ الدفع',
                                                  style: Styles.style5.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'رقم الطلب',
                                                  style: Styles.style5.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'العمولة',
                                                  style: Styles.style5.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'المبلغ الصافي',
                                                  style: Styles.style5.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'الحالة',
                                                  style: Styles.style5.copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              height: 2,
                                              color: AppColors.whiteColor2,
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// ✅ **قائمة المدفوعات (تأخذ كل الارتفاع المتبقي)**
                                      Expanded(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (context, index) => EarnRow(
                                                earn:
                                                    
                                                      commiessionModel!
                                                        .commissionDetails![index],
                                              ),
                                          separatorBuilder:
                                              (context, index) => const Divider(
                                                height: 2,
                                                color: AppColors.whiteColor2,
                                              ),
                                          itemCount:
                                              
                                                  commiessionModel!
                                                  .commissionDetails!
                                                  .length,
                                        ),
                                      ),

                                      SizedBox(height: 20.h),

                                      /// ✅ **زر سحب الأرباح**
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        child: ServiceButton(
                                          title: 'سحب الأرباح',
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
