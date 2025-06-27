import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/subscribe_model.dart';

class SubscribeCard extends StatelessWidget {
  final SubscribeModel subscribeModel;
  final void Function()? onTap ;
  const SubscribeCard({super.key, required this.subscribeModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: HelperFunctions.screenWidth(),
        decoration: BoxDecoration(
          color: AppColors.whiteColor3,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'الاشتراك ${subscribeModel.id.toString()}',
                    style: Styles.style1,
                  ),
                  Spacer(),
                  Text('مدة الاشتراك ${subscribeModel.time} شهر'),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    'السعر ${subscribeModel.price.toString()}',
                    style: Styles.style1.copyWith(color: AppColors.red),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.whiteColor,
                    ),
                    child: GestureDetector(
                      onTap:onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'اشتراك',
                          style: Styles.style5.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
