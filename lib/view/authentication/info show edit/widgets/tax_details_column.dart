import 'package:flutter/material.dart';
import 'custom_row.dart';
import 'custom_title_row.dart';

class TaxDetailsColumn extends StatelessWidget {
  const TaxDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleRow('التفاصيل القانونيه والضريبيه'),
        CustomRow(title: 'الاسم التجارى', info: 'الاسم التجارى'),
        CustomRow(title: 'رقم الرخصه التجاريه', info: '123456789'),
        CustomRow(title: 'تاريخ انتهاء الرخصه التجاريه', info: '25/2/2024'),
        CustomRow(title: 'الرقم الضريبى', info: '1234566778'),
        CustomRow(title: 'الرقم الضريبى', info: '5%'),
      ],
    );
  }
}
