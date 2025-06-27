import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CardInfo extends StatelessWidget {
  final int id;
  final void Function()? onTap;
  const CardInfo({super.key, required this.id, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
          trailing: id == 8
              ? SizedBox()
              : id == 4
                  ? Icon(
                      Icons.toggle_off,
                      color: AppColors.lightGrey,
                      size: 30,
                    )
                  : InkWell(
                      onTap: onTap,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColors.lightGrey,
                      ),
                    ),
          title: Text(
            id == 1
                ? 'معلومات الحساب'
                : id == 2
                    ? 'الموقع'
                    : id == 3
                        ? 'الرقم السري'
                        : id == 4
                            ? 'الاشعارات الفورية'
                            : id == 5
                                ? 'تتبع طلب الخدمه'
                                : id == 6
                                    ? 'عن التطبيق'
                                    : id == 7
                                        ? 'مواقع التواصل الاجتماعي'
                                        : 'تسجيل الخروج',
            style: Styles.style1.copyWith(color: AppColors.charcoalGrey),
          ),
          subtitle: Text(
            id == 1
                ? 'قم بتغيير معلومات حسابك'
                : id == 2
                    ? 'تغيير الموقع الخاص بك'
                    : id == 3
                        ? 'تغيير الرقم السرى الخاص بك'
                        : id == 4
                            ? 'قم بتفعيل الاشعارات  '
                            : id == 5
                                ? 'تتبع طلب الخدمه الخاصه بك'
                                : id == 6
                                    ? 'تعرف على المزيد حول تطبيقنا وخدماتنا '
                                    : id == 7
                                        ? 'تعابعنا على مواقع التواصل الاجنماعى الخاصه بنا'
                                        : ' ',
            style: Styles.style4.copyWith(color: AppColors.lightGrey),
          ),
          leading: id == 1
              ? Icon(Iconsax.user)
              : id == 2
                  ? Icon(Iconsax.location)
                  : id == 3
                      ? Icon(Iconsax.lock)
                      : id == 4
                          ? Icon(Iconsax.notification)
                          : id == 5
                              ? Icon(
                                  Iconsax.location,
                                  color: AppColors.charcoalGrey,
                                )
                              : id == 6
                                  ? SvgPicture.asset(AppImageAsset.social)
                                  : id == 7
                                      ? Icon(Icons.info_outline)
                                      : Icon(Iconsax.login)),
    );
  }
}
