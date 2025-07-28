import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/view/earnings/widgets/earn_card.dart';

class EarnRowCard extends StatelessWidget {
  final String total;
  final String pending;
  final String completed;
  const EarnRowCard({super.key, required this.total, required this.pending, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         EarnCard(
number:total ,
          title: 'all',
        ),
        SizedBox(
          width: 10.w,
        ),
         EarnCard(
          number:pending ,
          title: 'pend',
        ),
        SizedBox(
          width: 10.w,
        ),
         EarnCard(
          number:completed ,
          title: 'paid',
        ),
      ],
    );
  }
}
