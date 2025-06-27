/* import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';
import '../widgets/card_opinion.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DitailsColumn extends StatelessWidget {
  final BoxConstraints constraints;
  const DitailsColumn({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
  //  final screenHeight = MediaQuery.of(context).size.height;
  //  final screenWidth = MediaQuery.of(context).size.width;
    List images = [
      AppImageAsset.im1,
      AppImageAsset.im2,
      AppImageAsset.im3,
      AppImageAsset.im1
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('اطلب صناعي صيانة',
          style: Styles.style6.copyWith(color: AppColors.primaryColorBold)),
      const SizedBox(height: 10),

      Row(
        children: [
          const Icon(
            Iconsax.clock5,
            color: Colors.grey,
            size: 20,
          ),
          SizedBox(width: 5.w),
          Text('15 دقيقة',
              style: Styles.style4.copyWith(color: AppColors.charcoalGrey)),
          SizedBox(width: 10.w),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 16.sp,
          ),
          SizedBox(width: 5.w),
          Text('4.4 (80)',
              style: Styles.style1.copyWith(color: AppColors.greyColor))
        ],
      ),
      SizedBox(height: 16.h),
      // كود الترويج
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: ' وفر ',
                  style: Styles.style4.copyWith(color: AppColors.charcoalGrey)),
              TextSpan(
                  text: '100',
                  style: Styles.style4.copyWith(color: AppColors.primaryColor)),
              TextSpan(
                  text: '  مع استخدام كود nour123',
                  style: Styles.style4.copyWith(color: AppColors.charcoalGrey))
            ])),
            Icon(Icons.percent, size: 20.sp, color: AppColors.primaryColor),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Divider(thickness: 1),

      // التبويبات
      SizedBox(
        height: constraints.maxHeight / 2.5,
        child: ContainedTabBarView(
            tabBarProperties: const TabBarProperties(
                height: 40,
                indicatorWeight: 2,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppColors.primaryColor),
                unselectedLabelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                indicatorColor: AppColors.primaryColor),
            tabs: const [
              Text('الاراء'),
              Text('الصور'),
            ],
            views: [
              // تبويب الآراء
              ListView(
                children: [
                  ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) =>  CardOpinion(ratingModel: r,),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              // تبويب الصور باستخدام StaggeredGridView
              ListView(
                children: [
                  GridView.custom(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 0,
                      pattern: [
                     const   WovenGridTile(1),
                  const      WovenGridTile(
                          5 / 7,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8), // Add rounded corners
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover, // Ensure images fit tiles
                        ),
                      ),
                      childCount:
                          images.length, // Ensure the list length matches
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )
            ]),
      )
    ]);
  }
}
 */