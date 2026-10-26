import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class BuildCell extends StatelessWidget {
  const BuildCell({
    Key? key,
    this.isHeader = false,
    required this.text,
    this.flex = 1,
    this.isTextCenter = true,
  }) : super(key: key);
  final bool isHeader;
  final String text;
  final int flex;
  final bool isTextCenter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: isHeader ? Border.all(color: const Color(0xffDADCE3)) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            textAlign: isTextCenter ? TextAlign.center : TextAlign.right,
            maxLines: 1,
            style: const TextStyle(
              color: AppColor.c121212,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
