import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_colors.dart';

class CustomFieldSearch extends StatelessWidget {
  final double height;
  final bool isorderScreen;
  const CustomFieldSearch({super.key, required this.isorderScreen, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:height,
      height: 40.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor:isorderScreen?AppColors.primaryColorWithOpacity2: AppColors.primaryColorWithOpacity2,
            hintText: 'ابحث هنا',
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.charcoalGrey,
              size: 15, // حجم الأيقونة
            ),
            hintStyle: TextStyle(
              color:isorderScreen?AppColors.charcoalGrey: Colors.grey,
              fontSize: 16.sp, // حجم النص
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  BorderSide(color:isorderScreen? AppColors.whiteColor3:AppColors.whiteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: isorderScreen? AppColors.whiteColor3:AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
