import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/styles.dart';

import '../../../../core/constant/app_colors.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.whiteColor2),
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: HelperFunctions.screenWidth(),
                decoration: BoxDecoration(
                    color: AppColors.primaryColorWithOpacity2,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '8:00 pm',
                                  style: Styles.style5
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '10 Jan',
                                  style: Styles.style5
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'نور على',
                              style:
                                  Styles.style5.copyWith(color: AppColors.black),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'المنصوره شارع احمد ماهر',
                              style:
                                  Styles.style5.copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
      
                    // icons
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor)),
                          child: const Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.phone,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Iconsax.message1,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name & code
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اسم المنتج',
                        style: Styles.style1,
                      ),
                    
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '# كود الطلب : ',
                            style:
                                Styles.style4.copyWith(color: AppColors.black)),
                        TextSpan(
                            text: '111111122',
                            style: Styles.style4
                                .copyWith(color: AppColors.primaryColor))
                      ])),
                    ],
                  ),
                  // but
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColors.primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'قبول الطلب',
                            style: Styles.style5
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'رفض الطلب',
                            style: Styles.style5
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
