import 'package:flutter/material.dart';
import '../../../config/theme/app_color.dart';

class BuildOrderSummeryWidget extends StatelessWidget {
  const BuildOrderSummeryWidget({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColor.c717171,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.c717171,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
