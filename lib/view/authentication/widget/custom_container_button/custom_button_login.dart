import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';
import 'custom_container_button.dart';

class CustomButtonLogin extends StatelessWidget {
  final bool isLogin;
  final void Function()? onTap;
  final bool textn;

  const CustomButtonLogin(
      {super.key, required this.isLogin, required this.textn, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color textColor = textn
        ? AppColors.whiteColor
        : isLogin
            ? AppColors.whiteColor
            : AppColors.primaryColor;
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: CustomContainerButton(
        borderColor: AppColors.primaryColor,
        color: textn
            ? AppColors.primaryColor
            : isLogin
                ? AppColors.primaryColor
                : AppColors.whiteColor,
        child: Text(
            textn
                ? 'انشاء حساب'
                : isLogin
                    ? 'تسجيل الدخول'
                    : 'انشاء حساب',
            style: Styles.style1.copyWith(color: textColor)),
      ),
    );
  }
}
