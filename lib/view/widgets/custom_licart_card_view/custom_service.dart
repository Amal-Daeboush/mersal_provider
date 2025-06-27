import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CustomService extends StatelessWidget {
  final String name;
  final bool isSelected;
  final String image;
  const CustomService(
      {super.key,
      required this.name,
      required this.image,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.whiteColor3),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                image,
                height: 30,
                   color: isSelected
                    ? AppColors.whiteColor3
                    : AppColors.primaryColor
              ),
            ),
          ),
          Text(
            name,
            style: Styles.style1_copy2,
          )
        ],
      ),
    );
  }
}
