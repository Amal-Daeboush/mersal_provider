import 'package:flutter/material.dart';
import 'package:provider_mersal/core/constant/styles.dart';

Widget DiscoutButton(
  String title,
  void Function() onPressed,
  Color backgroundColor,
  Color textcolor,
) {
  return ElevatedButton(
    onPressed: onPressed,

    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Text(title, style: Styles.style4.copyWith(color: textcolor)),
    ),
  );
}
