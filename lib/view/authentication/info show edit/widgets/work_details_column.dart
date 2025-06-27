import 'package:flutter/material.dart';
import 'custom_row.dart';
import 'custom_title_row.dart';

class WorkDetailsColumn extends StatelessWidget {
  const WorkDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleRow('تفاصيل العمل'),
        CustomRow(title: 'اسم العلامه التجاريه', info: 'اسم العلامه التجاريه'),
        CustomRow(title: 'نوع العمل', info: 'نوع العمل'),
        CustomRow(title: 'عدد الفروع', info: '1'),
        CustomRow(title: 'رقم التواصل', info: '01234567891'),
      ],
    );
  }
}
