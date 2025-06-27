import 'package:flutter/material.dart';

import 'custom_row.dart';
import 'custom_title_row.dart';

class AddressColumn extends StatelessWidget {
  const AddressColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleRow('عنوان العمل'),
     
        CustomRow(title: 'المنصوره_احمد ماهر', info: ''),
       
      ],
    );
  }
}