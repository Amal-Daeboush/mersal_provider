import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_mersal/view/earnings/widgets/earn_card.dart';

class EarnRowCard extends StatelessWidget {
  const EarnRowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const EarnCard(
          title: 'all',
        ),
        SizedBox(
          width: 10.w,
        ),
        const EarnCard(
          title: 'pend',
        ),
        SizedBox(
          width: 10.w,
        ),
        const EarnCard(
          title: 'paid',
        ),
      ],
    );
  }
}
