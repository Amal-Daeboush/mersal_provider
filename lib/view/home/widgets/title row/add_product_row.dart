import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class AddRow extends StatelessWidget {
  final void Function()? add;
  final bool isSrervice;
  final bool isfood;
  const AddRow({
    super.key,
    required this.isSrervice,
    this.add,
    required this.isfood,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isSrervice
              ? 'تحكم في خدماتك الآن'
              : isfood
              ? 'تحكم في اطباقك الان'
              : ' تحكم في منتجاتك الآن',
          style: Styles.style1.copyWith(
            color: AppColors.primaryColorBold,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: add,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Text(
                isSrervice
                    ? 'إضافة خدمة جديدة'
                    : isfood
                    ? 'إضافة طبق جديد'
                    : 'إضافة منتج جديدة',
                style: Styles.style5.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
