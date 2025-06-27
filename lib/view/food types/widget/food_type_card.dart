import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/helper_functions.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/food_type_model.dart';


class FoodTypeCard extends StatelessWidget {
  final FoodTypeModel foodTypeModel;
  final void Function()? onTap;
  const FoodTypeCard({super.key, required this.foodTypeModel, this.onTap});

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
          child: Row(
            children: [
              Text(foodTypeModel.title, style: Styles.style1),
              Spacer(),
              IconButton(
                onPressed: onTap,
                icon: Icon(Iconsax.trash, color: AppColors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
