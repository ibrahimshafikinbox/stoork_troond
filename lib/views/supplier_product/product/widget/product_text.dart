import 'package:flutter/material.dart';
import '../../../../config/theme/app_color.dart';

class BorderText extends StatelessWidget {
  const BorderText({
    super.key,
    required this.child,
    required this.height,
    required this.text,
  });

  final String text;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.cDADCE3,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: child,
        ),
        Positioned(
          left: 50,
          top: 12,
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 0,
              left: 10,
              right: 10,
            ),
            color: Colors.white,
            child: Text(
              text,
              style: const TextStyle(
                color: AppColor.c414141,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
