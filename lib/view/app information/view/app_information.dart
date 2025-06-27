import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';
import '../widget/infio_app_bar.dart';

class AppInformation extends StatelessWidget {
  const AppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const InfioAppBar(),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'تم تطوير هذا التطبيق بواسطة ',
                              style: Styles.style1.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'High Level Technology ',
                              style: Styles.style1.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'نحن نؤمن بأن التكنولوجيا قادرة على تبسيط حياتنا اليومية وتحسين تجاربنا في مختلف المجالات. لذلك قمنا بتطوير هذا التطبيق ليكون الحل الأمثل لربط المستخدمين بمزودي الخدمات والمنتجات بطريقة آمنة وسريعة.',
                        style: Styles.style4.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'يهدف التطبيق الى',
                        style: Styles.style1.copyWith(color: AppColors.black),
                      ),
                      ListTile(
                        leading: Image.asset(
                          AppImageAsset.sun,
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                        title: Text(
                          'تسهيل الوصول إلى الخدمات',
                          style: Styles.style4.copyWith(color: AppColors.black),
                        ),
                        subtitle: Text(
                          'من خلال واجهة مستخدم بسيطة تتيح البحث عن الخدمات أو المنتجات بسهولة بناءً على الموقع أو التصنيف.',
                          style: Styles.style4.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      ListTile(
                        leading: Image.asset(
                          AppImageAsset.sun,
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                        title: Text(
                          'دعم أصحاب الأعمال الصغيرة',
                          style: Styles.style4.copyWith(color: AppColors.black),
                        ),
                        subtitle: Text(
                          'من خلال تمكينهم من عرض خدماتهم ومنتجاتهم وزيادة قاعدة عملائهم.',
                          style: Styles.style4.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      ListTile(
                        leading: Image.asset(
                          AppImageAsset.sun,
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                        title: Text(
                          'تعزيز تجربة التوصيل',
                          style: Styles.style4.copyWith(color: AppColors.black),
                        ),
                        subtitle: Text(
                          'عبر نظام ذكي يربط بين الطلبات والمندوبين لضمان سرعة ودقة التوصيل',
                          style: Styles.style4.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'نحن في ',
                              style: Styles.style1.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'High Level Technology ',
                              style: Styles.style1.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'نسعى دائمًا لتطوير تقنيات مبتكرة تلبي احتياجات المستخدمين وتعزز من كفاءة الخدمات اليومية.',
                              style: Styles.style1.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'رابط الموقع الإلكتروني',
                        style: Styles.style1.copyWith(color: AppColors.black),
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          final Uri url = Uri.parse(
                            'https://highleveltecknology.com/',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            Get.snackbar('خطأ', 'تعذر فتح الرابط');
                          }
                        },
                        child: Text(
                          'https://highleveltecknology.com/',
                          style: Styles.style1.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
