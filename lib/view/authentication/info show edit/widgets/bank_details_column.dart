import 'package:flutter/material.dart';

import 'custom_title_row.dart';

class BankDetailsColumn extends StatelessWidget {
  const BankDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleRow('تفاصيل البنك'),
      ],
    );
  }
}
