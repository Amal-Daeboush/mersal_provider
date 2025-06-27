import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/discount/controller/discount_controller.dart';
import 'package:provider_mersal/view/discount/widget/discount_button.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';


 void EditDiscountDialog(BuildContext context, ProductModel product) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(child: Text('تعديل الخصم', style: Styles.style1)),
        content: GetBuilder<DiscountController>(
          init: DiscountController(productModel: product),
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // حقل قيمة الخصم
                TextFormField(
                  controller: controller.descount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    hintText: 'ادخل قيمة الخصم هنا',
                    helperStyle: Styles.style5.copyWith(color: AppColors.red),
                    helperText: 'لو وضعت الخصم 10 يكون الخصم بنسبة 10%',
                    hintStyle: Styles.style5.copyWith(color: Color.fromARGB(255, 7, 9, 12)),
                    filled: true,
                    fillColor: AppColors.whiteColor2,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // حقل تاريخ البداية
                TextField(
                  readOnly: true,
                  controller: controller.firstDateDiscount,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month, size: 20, color: AppColors.lightGrey3),
                    contentPadding: EdgeInsets.all(2),
                    hintText: 'ادخل تاريخ بداية الخصم',
                    helperStyle: Styles.style5.copyWith(color: AppColors.red),
                    helperText: 'عند الوصول للتاريخ يصبح الخصم فعال',
                    hintStyle: Styles.style5.copyWith(color: Color.fromARGB(255, 7, 9, 12)),
                    filled: true,
                    fillColor: AppColors.whiteColor2,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // حقل تاريخ النهاية
                TextField(
                  readOnly: true,
                  controller: controller.lastDateDiscount,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month, size: 20, color: AppColors.lightGrey3),
                    contentPadding: EdgeInsets.all(2),
                    hintText: 'ادخل تاريخ نهاية الخصم',
                    helperStyle: Styles.style5.copyWith(color: AppColors.red),
                    helperText: 'عند نهاية هذا التاريخ ينتهي الخصم تلقائيًا',
                    hintStyle: Styles.style5.copyWith(color: Color.fromARGB(255, 7, 9, 12)),
                    filled: true,
                    fillColor: AppColors.whiteColor2,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.whiteColor2),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // الأزرار
                Column(
                  children: [
                    // زر تعديل الخصم
                    DiscoutButton(
                      'تعديل قيمة الخصم',
                      () async {
                        if (controller.descount.text.isEmpty) {
                          Get.snackbar('تنبيه', 'يرجى تعبئة جميع الحقول');
                          return;
                        }
                        await controller.EditDiscount(product.id.toString());
                        Navigator.of(context).pop();
                         Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 100), () {
                          Get.snackbar('نجاح', 'تم تعديل الخصم بنجاح');
                        });
                      },
                      AppColors.primaryColor,
                      AppColors.whiteColor,
                    ),
                    // زر تغيير الحالة (يمكن تطويره لاحقًا)
                /*     DiscoutButton(
                      'تغيير حالة الخصم',
                      () {
                        // يمكنك إضافة المنطق هنا
                      },
                      AppColors.whiteColor2,
                      AppColors.primaryColor,
                    ), */
                    // زر الحذف
                    DiscoutButton(
                      'إزالة الخصم',
                      () async {
                        await controller.deleteDiscount(product.id.toString());
                        Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 100), () {
                          Get.snackbar('نجاح', 'تم حذف الخصم بنجاح');
                        });
                      },
                      AppColors.red,
                      AppColors.whiteColor,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
