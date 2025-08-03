import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/order_model.dart';
import '../../../../../core/constant/app_colors.dart';

class OrderCard2 extends StatelessWidget {
  final OrderModel order;
  const OrderCard2({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    String formatSmartDate(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final difference = today.difference(aDate).inDays;

      final time =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      if (difference == 0) {
        return '$time\nToday';
      } else if (difference == 1) {
        return '$time\nYesterday';
      } else {
        final date = DateFormat('d MMMM').format(dateTime); // مثل: 10 June
        return '$time\n$date';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: HelperFunctions.screenWidth(),
                decoration: BoxDecoration(
                  color: AppColors.primaryColorWithOpacity2,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatSmartDate(order.orderDetails.createdAt),

                                  style: Styles.style5.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.userInfo?.user.name ?? 'مستخدم غير معروف',

                              style: Styles.style5.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                                order.userInfo?.profile.address ?? ' موقع غير معروف',
                              style: Styles.style5.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // icons
                    Row(
                      children: [
                        /*   Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: const Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.phone,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ), */
                        //   SizedBox(width: 10.w),
                        /*                         Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Iconsax.message1,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ), */
                        //   SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name & code
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المنتجات المطلوبة:',
                            style: Styles.style4.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          ...order.products.map((product) {
                            return Text(
                              '- ${product.productName} (x${product.quantity})',
                              style: Styles.style5.copyWith(
                                color: AppColors.black,
                              ),
                            );
                          }).toList(),
                        ],
                      ),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '# كود الطلب : ',
                              style: Styles.style4.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: order.orderId.toString(),
                              style: Styles.style4.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                         RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: " الملاحظات: ",
                              style: Styles.style4.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text:"",
                              style: Styles.style4.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // but
                 /*  order.orderDetails.status == "pending"
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          order.orderDetails.status == "pending"
                              ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: AppColors.primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'قبول الطلب',
                                    style: Styles.style5.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox(),
                          SizedBox(width: 5.w),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'رفض الطلب',
                                style: Styles.style5.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : SizedBox(), */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
