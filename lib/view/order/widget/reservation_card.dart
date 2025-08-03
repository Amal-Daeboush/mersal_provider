import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/reservation_model.dart';
import 'package:provider_mersal/view/chat%20screen/view/your_chat_screen.dart';
import 'package:provider_mersal/view/order/controller/order_controller.dart';
import 'package:provider_mersal/view/order/view/user_location_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constant/app_colors.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel order;
  final OrderController? orderController;
  const ReservationCard({super.key, required this.order, this.orderController});

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
    print(order.userInfo!.user.lat??'');
   print(order.userInfo!.user.name);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  formatSmartDate(order.createdAt),

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
                              order.user.name,
                              style: Styles.style5.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              order.userInfo?.profile.address ??
                                  'موقع غير معروف',
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
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            final Uri phoneUri = Uri.parse(
                              'tel:${order.user.phone}',
                            );
                            if (await canLaunchUrl(phoneUri)) {
                              await launchUrl(phoneUri);
                            } else {
                              Get.snackbar('خطأ', 'تعذر فتح تطبيق الاتصال');
                            }
                          },
                          child: Container(
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
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap:
                              () => Get.to(
                                YourChatScreen(
                                  senderName: order.user.name,
                                  id: order.user.id,
                                ),
                              ),
                          child: Container(
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
                          ),
                        ),
                        SizedBox(width: 10.w),
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
                      Text(order.product.name, style: Styles.style1),
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
                              text: order.id.toString(),
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
                  order.status == "pending"
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          order.status == "pending"
                              ? GestureDetector(
                                onTap:
                                    () => orderController!
                                        .updatestatusReservation(
                                          order.id.toString(),
                                          false,
                                        ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      ' تم اكمال الخدمة',
                                      style: Styles.style5.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox(),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap:
                                () => orderController!.updatestatusReservation(
                                  order.id.toString(),
                                  true,
                                ),

                            child: Container(
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
                          ),
                        ],
                      )
                      : SizedBox(),
                ],
              ),
              GestureDetector(
                onTap:
                    () => Get.to(
                      UserLocationScreen(
                        lat: order.userInfo!.user.lat!??'',
                        lang: order.userInfo!.user.lang!??'',
                      ),
                    ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: AppColors.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'عرض موقع العميل',
                      style: Styles.style5.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
