import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/discount/widget/discount_button.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

void showDiscountDialog(
  BuildContext context,
  TextEditingController discountController,
  TextEditingController firstdatecountController,
  TextEditingController lastdatecountController,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(child: Text('اضافة خصم', style: Styles.style1)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: discountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال قيمة الخصم';
                }
                final numValue = num.tryParse(value);
                if (numValue == null || numValue < 1 || numValue > 100) {
                  return 'قيمة الخصم يجب أن تكون بين 1 و 100';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                hintText: ' ادخل قيمة الخصم هنا .  ',

                helperStyle: Styles.style5.copyWith(color: AppColors.red),
                helperText: 'لو وضعت الخصم 10 يكون الخصم بنسبة 10% ',
                hintStyle: Styles.style5.copyWith(
                  color: const Color.fromARGB(255, 7, 9, 12),
                ),
                filled: true,
                fillColor: AppColors.whiteColor2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              readOnly: true, // يمنع التعديل اليدوي
              onTap: () {
                pickDateTime(context, firstdatecountController);
              },

              controller: firstdatecountController,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: AppColors.lightGrey3,
                ),

                contentPadding: EdgeInsets.all(2),
                hintText: ' ادخل  تاريخ بداية تفعيل الخصم  .  ',

                helperStyle: Styles.style5.copyWith(color: AppColors.red),
                helperText: ' عند الوصول  لليوم المحدد يصبح الخصم  فعال',
                hintStyle: Styles.style5.copyWith(
                  color: const Color.fromARGB(255, 7, 9, 12),
                ),
                filled: true,
                fillColor: AppColors.whiteColor2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: lastdatecountController,
              readOnly: true, // يمنع التعديل اليدوي
              onTap: () {
                pickDateTime(context, lastdatecountController);
              },

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: AppColors.lightGrey3,
                ),

                contentPadding: EdgeInsets.all(2),
                hintText: ' ادخل اقصى تاريخ لصلاحية الخصم  .  ',

                helperStyle: Styles.style5.copyWith(color: AppColors.red),
                helperText:
                    ' عند الوصول لنهاية اليوم المحدد يصبح الخصم غير فعال',
                hintStyle: Styles.style5.copyWith(
                  color: const Color.fromARGB(255, 7, 9, 12),
                ),
                filled: true,
                fillColor: AppColors.whiteColor2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: AppColors.whiteColor2),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            DiscoutButton(
              'تأكيد الخصم',
              () {
                if (discountController.text.isEmpty ||
                    firstdatecountController.text.isEmpty ||
                    lastdatecountController.text.isEmpty) {
                  Get.snackbar('خطأ', 'يرجى تعبئة جميع الحقول');
                  return;
                }

                // ✅ تحقق من التواريخ هنا
                DateTime start =
                    DateTime.tryParse(firstdatecountController.text) ??
                    DateTime.now();
                DateTime end =
                    DateTime.tryParse(lastdatecountController.text) ??
                    DateTime.now();

                if (!end.isAfter(start)) {
                  Get.snackbar(
                    'خطأ',
                    'تاريخ نهاية الخصم يجب أن يكون بعد تاريخ البداية',
                  );
                  return;
                }
                final discountValue = num.tryParse(
                  discountController.text.trim(),
                );
                if (discountValue == null ||
                    discountValue < 1 ||
                    discountValue > 100) {
                  Get.snackbar('خطأ', 'قيمة الخصم يجب أن تكون بين 1 و 100');
                  return;
                }
                Navigator.pop(context); // أو Get.back();
                onConfirm(); // ✅ نفذ الإضافة فقط بعد التأكد
              },
              AppColors.primaryColor,
              AppColors.whiteColor,
            ),
          ],
        ),
      );
    },
  );
}

Future<void> pickDateTime(
  BuildContext context,
  TextEditingController controller,
) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  if (date == null) return;

  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (time == null) return;

  DateTime fullDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  // تحويل إلى نص بالشكل المطلوب
  String formatted = fullDateTime.toString(); // الناتج: 2025-12-01 08:30:00
  controller.text = formatted;
}
