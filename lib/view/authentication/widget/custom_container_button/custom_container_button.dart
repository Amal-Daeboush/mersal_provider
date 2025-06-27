import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainerButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Widget? child;
final void Function()? onTap;
  const CustomContainerButton(
      {super.key, required this.borderColor, this.child, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: color,
            border: Border.all(color: borderColor)),
        child: Padding(
            padding: const EdgeInsets.all(8.0), child: Center(child: child)),
      ),
    );
  }
}
