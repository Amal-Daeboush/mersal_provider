import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class AuthDropDow1 extends StatelessWidget {
  final String? selectedValue;
  final void Function(String?)? onChanged;
  const AuthDropDow1({super.key, this.selectedValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: SizedBox(),
      isExpanded: true,menuWidth: 200.w,
   
      iconEnabledColor: AppColors.primaryColor,
      value: selectedValue,
      items: [
        DropdownMenuItem<String>(
          value: 'service_provider',
          child: Text(
            'مزود الخدمة',
            style: Styles.style1.copyWith(color: AppColors.lightGrey),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'product_provider',
          child: Text(
            'مزود المنتج',
            style: Styles.style1.copyWith(color: AppColors.lightGrey),),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
class AuthDropDow extends StatelessWidget {
  final String? selectedValue;
  final void Function(String?)? onChanged;
  const AuthDropDow({super.key, this.selectedValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
         iconStyleData:const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              iconSize: 24,
              iconEnabledColor: AppColors.primaryColorBold
            ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
         // width: HelperFunctions.screenWidth(),
           // أقصى ارتفاع للقائمة
          offset: const Offset(0, 15), // تعيين الإزاحة
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        underline: const SizedBox(),
        isExpanded: true,
        hint: Text(
          'طريقة الدفع',
          style: Styles.style4,
        ),
        //   iconEnabledColor: AppColors.primaryColor,
        value: selectedValue,
        items: [
          DropdownMenuItem<String>(
            value: 'service_provider',
            child: Text(
               'مزود الخدمة',
              style: Styles.style1.copyWith(color: AppColors.lightGrey),
            ),
          ),
          DropdownMenuItem<String>(
            value: 'product_provider',
            child: Text(
               'مزود المنتج',
              style: Styles.style1.copyWith(color: AppColors.lightGrey),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}