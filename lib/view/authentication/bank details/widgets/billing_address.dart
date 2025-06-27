import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/authentication/info%20show%20edit/view/info_show_edit_screen.dart';

import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_button_next.dart';
import '../../widget/text_field/custom_text_form_field.dart';

Widget BillingAddress(String prov) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('عنوان ارسال الفواتير الخاصه بك', style: Styles.style4),
      SizedBox(height: 10.h),
      CheckboxMenuButton(
        value: true,
        onChanged: (value) {},
        child: Text(
          'عنوان الفواتير وعنوان العمل بى نفس العنوان',
          style: Styles.style4,
        ),
      ),
      const CustomTextFormField(
        hintText: 'المنصوره_احمد ماهر',
        obscureText: false,
        isPassWord: false,
        maxLines: 2,
      ),
      SizedBox(height: 10.h),
      CustomButtonNext(
        onTap: () => Get.off(InfoShowEditScreen(prov: prov)),
      ),
      SizedBox(height: 20.h),
    ],
  );
}
