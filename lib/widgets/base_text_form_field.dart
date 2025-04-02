import 'package:ar_flutter/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseTextFormField extends StatelessWidget {
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final int? maxLines;
  final Color? textColor;
  final TextEditingController? controller;
  final String? Function(String?)? validateFunction;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enabled;
  final double? labelSize;
  final Color? cursorColor;

  const BaseTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly,
    this.maxLines,
    this.controller,
    this.hint,
    this.validateFunction,
    this.textInputType,
    this.obscureText,
    this.enabled,
    this.textColor,
    this.labelSize,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorColor: cursorColor ?? AppColors.primaryBlue,
        keyboardType: textInputType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        textInputAction: TextInputAction.go,
        style: TextStyle(
            color: textColor ?? AppColors.primaryBlue,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintStyle: TextStyle(color: AppColors.lightGrey, fontSize: 14, fontWeight: FontWeight.w500),
            hintText: hint),
        validator: validateFunction);
  }
}
