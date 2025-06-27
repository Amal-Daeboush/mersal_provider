import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider_mersal/model/category_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';


class CategoryDropDown extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final void Function(CategoryModel?)? onChanged;

  const CategoryDropDown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<CategoryModel>(
      value: selectedCategory,
      isExpanded: true,
      underline:SizedBox(),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColorBold),
      ),
      dropdownStyleData: DropdownStyleData(
        
        offset: const Offset(0, 10),
        maxHeight: 250,
        width: 220,
        decoration: BoxDecoration(
          color:  AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColorBold),
        ),
      ),
      items: categories.map((cat) {
        return DropdownMenuItem<CategoryModel>(
          value: cat,
          child: Text(
            cat.name,
            style: Styles.style4.copyWith(color: AppColors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      selectedItemBuilder: (_) {
        return categories.map((cat) {
          return Text(
            cat.name,
            style: Styles.style4.copyWith(color: AppColors.black),
          );
        }).toList();
      },
    );
  }
}
