import 'package:flutter/material.dart';

class LogoSvg extends StatelessWidget {
  const LogoSvg({super.key, this.height = 24.0});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/trond-logo.png",
      height: height,
      fit: BoxFit.contain,
    );
  }
}