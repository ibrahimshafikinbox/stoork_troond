import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({
    super.key,
    required this.text,
    this.textColor = AppColor.c121212,
    this.fontSize = 20,
  });
  final String text;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }
}
