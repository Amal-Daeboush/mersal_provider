import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon?suffixIcon;
  final Color? color;
  final bool? enabel;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)?
      validator; // ملاحظة: هنا يجب أن تكون String? Function(String?) لجعلها متوافقة
  final int? maxLines;
  final bool obscureText;
  final bool isPassWord;
  final Icon? icon;
  final bool readOnly ;
  final void Function()? onTap;
  final void Function()? onTapobscure;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.color,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines,
    required this.obscureText,
    required this.isPassWord,
    this.icon,
    this.onTapobscure, this.suffixIcon, this.enabel,  this.readOnly=false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onTap: onTap,
        readOnly:readOnly ,
        enabled: enabel,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'ها الحقل لا  يمكن ان يكون فارغ';
              }
              return null;
            },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: maxLines,
        style: Styles.style4.copyWith(color: AppColors.black,fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          
          prefixIcon: prefixIcon,
          suffixIcon:suffixIcon ,
          suffix: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: isPassWord
                ? InkWell(onTap: onTapobscure, child: icon!)
                : Icon(
                    Icons.check_circle,
                    color:color?? AppColors.lightGrey3,
                    size: 15,
                  ),
          ),
          hintText: hintText,
          fillColor: AppColors.lightGrey2,
          filled: true,
          hintStyle: Styles.style12.copyWith(color: AppColors.lightGrey),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 3, horizontal: 15), 
              disabledBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.lightGrey2),
          ) ,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.lightGrey2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColors.red,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.lightGrey2),
          ),
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
