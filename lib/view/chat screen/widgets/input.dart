import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CommentInputSection extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController? controller;
  const CommentInputSection({super.key, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: AppColors.greyColor2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            // Text Field for New Comment
            Expanded(
              child: TextField(
                focusNode: focusNode,
                style: Styles.style4,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  hintText: "ارسل رسالة...",
                  helperStyle: Styles.style4,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send Button
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              onTap: () {
                // إغلاق لوحة المفاتيح عند الإرسال
              //  focusNode.unfocus();
                if (onTap != null) onTap!();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Iconsax.send_2, color: AppColors.primaryColorBold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
