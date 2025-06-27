
import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';
import 'loading/custom_loading.dart';

class CustomGradientButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? price;
  final String? rightText;
  final TextStyle? style;
  final TextStyle? priceStyle;
  final TextStyle? rightTextStyle;
  final void Function()? onPressed;
  final double? width;
  final bool isLoading;

  const CustomGradientButton({
    super.key,
    this.text,
    this.icon,
    this.price,
    this.rightText,
    this.style,
    this.priceStyle,
    this.rightTextStyle,
    this.onPressed,
    this.width = double.infinity,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (price != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  price!,
                  style: priceStyle ?? const TextStyle(color: Colors.white),
                ),
              ),
            if (text != null)
              isLoading
                  ? const CustomLoading(
                      color: AppColors.whiteColor,
                    )
                  : Text(
                      text!,
                      style: style ??
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
            if (rightText != null || icon != null)
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (rightText != null)
                      Text(
                        rightText!,
                        style: rightTextStyle ??
                            const TextStyle(color: Colors.white),
                      ),
                    if (icon != null) ...[
                      const SizedBox(width: 5),
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
