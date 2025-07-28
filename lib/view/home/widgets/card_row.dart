import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider_mersal/view/home/widgets/card/custom_card.dart';

class CardRow extends StatelessWidget {
  final String ordersCounts;
  final String? commision;
  const CardRow({super.key, required this.ordersCounts, this.commision});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomCard(count: ordersCounts, title: 'order'),
        SizedBox(width: 10.w),
        CustomCard(count: commision ?? '0', title: 'inc'),
        SizedBox(width: 10.w),
        const CustomCard(title: 'feed'),
      ],
    );
  }
}
