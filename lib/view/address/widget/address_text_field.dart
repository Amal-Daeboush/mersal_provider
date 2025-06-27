import 'package:flutter/material.dart';

import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';

class AddressTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hint;
  final Widget? prefixIcon;

  const AddressTextFiled({
    super.key,
    this.controller,
    this.validator,
    required this.hint,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
             
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.red),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
           contentPadding: const EdgeInsets.symmetric(
              vertical: 3, horizontal: 15), 
        hintText: hint,
        
        hintStyle: Styles.style4,

        prefixIcon: prefixIcon,
        //     prefix: Icon(Iconsax.search_favorite)),
      ),
    );
  }
}
