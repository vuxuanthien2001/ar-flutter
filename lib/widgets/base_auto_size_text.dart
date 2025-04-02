import 'package:ar_flutter/themes/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BaseAutoSizeText extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final int? maxLines;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const BaseAutoSizeText(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      this.maxLines,
      this.textColor,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: width,
      height: height,
      child: AutoSizeText(
        text,
        style: TextStyle(
            fontSize: 30,
            color: textColor ?? AppColors.hardGrey,
            fontWeight: fontWeight),
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
