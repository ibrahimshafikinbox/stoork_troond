import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class BuildTextBtn extends StatelessWidget {
  const BuildTextBtn({
    super.key,
    required this.color,
    required this.onTap,
    required this.text,
    this.textColor = AppColor.white,
    this.padding = 20,
  });
  final Function()? onTap;
  final String text;
  final Color color;
  final Color textColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          )
        ),
        onPressed: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
