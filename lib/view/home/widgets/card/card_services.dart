import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/model/service_model.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image_asset.dart';
import '../../../../core/constant/styles.dart';
import 'custom_small_but.dart';

class CardServices extends StatelessWidget {
  final void Function()? edit;
  final ProductModel serviceModel;
  final void Function()? delete;
  final void Function()? refresh;
  final void Function()? ontap;
  final bool isProductCard;
  const CardServices({
    super.key,
    required this.isProductCard,
    this.edit,
    this.delete,
    this.refresh,
    this.ontap,
    required this.serviceModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: ontap,
        child: SizedBox(
          width: 150,
          child: Column(
            //D  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                // clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImageAsset.discount),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomSmallBut(
                            onTap: delete,
                            icon: const Icon(
                              Iconsax.trash,
                              size: 15,
                              color: AppColors.red,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          isProductCard
                              ? CustomSmallBut(
                                onTap: refresh,
                                icon: const Icon(
                                  Iconsax.repeate_music,
                                  size: 15,
                                  color: AppColors.primaryColor,
                                ),
                              )
                              : const SizedBox(),
                          SizedBox(width: 5.w),
                          CustomSmallBut(
                            onTap: edit,
                            icon: const Icon(
                              Icons.border_color_outlined,
                              size: 15,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          child: Text(
                            '${serviceModel.price} £',
                            style: Styles.style5.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      serviceModel.name,
                      style: Styles.style5.copyWith(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 15),
                        SizedBox(width: 5.w),
                        Text(
                          '(80) 4.4',
                          style: Styles.style5.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
