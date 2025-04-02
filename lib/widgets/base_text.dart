import 'package:ar_flutter/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? size;

  const BaseText(
      {super.key,
      required this.text,
      this.maxLines,
      this.textColor,
      this.fontWeight,
      this.textAlign,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: textColor ?? AppColors.hardGrey,
          fontWeight: fontWeight),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
