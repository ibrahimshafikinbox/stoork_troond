import 'package:flutter/material.dart';
import '../../../../config/theme/app_color.dart';

class AuthTextWidget extends StatelessWidget {
  const AuthTextWidget({
    super.key,
    required this.text,
    required this.nextText,
    required this.onTap,
  });
  final String text;
  final String nextText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppColor.c636363,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Text(
            nextText,
            style: const TextStyle(
              color: AppColor.main,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
