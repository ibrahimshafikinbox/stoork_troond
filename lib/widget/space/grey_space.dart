import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class GreySpace extends StatelessWidget {
  const GreySpace({
    super.key,
    this.hasText = false,
    this.text = "",
  });
  final bool hasText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hasText ? 35 : 10,
      width: double.infinity,
      color: AppColor.cE5E7EB,
      child: hasText
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColor.c3D3D3D,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
