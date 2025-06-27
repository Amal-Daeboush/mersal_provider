import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';

class ColumnBankTranslet extends StatelessWidget {
  const ColumnBankTranslet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextFormField(
            hintText: 'اسم البنك', obscureText: false, isPassWord: false),
        SizedBox(
          height: 15.h,
        ),
        const CustomTextFormField(
            hintText: 'رقم الحساب', obscureText: false, isPassWord: false),
        SizedBox(
          height: 15.h,
        ),
     const   CustomTextFormField(
            hintText: 'اسم صاحب الحساب', obscureText: false, isPassWord: false),
        SizedBox(
          height: 15.h,
        ),
        const CustomTextFormField(
            maxLines: 3,
            hintText: 'اضافة ملاحظة',
            obscureText: false,
            isPassWord: false),
      ],
    );
  }
}
