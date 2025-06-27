import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider_mersal/model/category_model.dart';
import 'package:provider_mersal/model/food_type_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CategoryFoodTypes extends StatelessWidget {
  final List<FoodTypeModel> types;
  final FoodTypeModel? selectedFood;
  final void Function(FoodTypeModel?)? onChanged;

  const CategoryFoodTypes({
    super.key,
    required this.types,
    required this.selectedFood,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<FoodTypeModel>(
      value: selectedFood,
      isExpanded: true,
      underline: SizedBox(),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColorBold),
      ),
      dropdownStyleData: DropdownStyleData(
        offset: const Offset(0, 10),
        maxHeight: 250,
        width: 220,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColorBold),
        ),
      ),
      items:
          types.map((cat) {
            return DropdownMenuItem<FoodTypeModel>(
              value: cat,
              child: Text(
                cat.title,
                style: Styles.style4.copyWith(color: AppColors.black),
              ),
            );
          }).toList(),
      onChanged: onChanged,
      selectedItemBuilder: (_) {
        return types.map((cat) {
          return Text(
            cat.title,
            style: Styles.style4.copyWith(color: AppColors.black),
          );
        }).toList();
      },
    );
  }
}
