import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/app_assets/app_assets.dart';

class SvgWidget extends StatelessWidget {
  const SvgWidget({
    super.key,
    required this.svgName,
  });
  final String svgName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.svgPath + svgName,
      fit: BoxFit.contain,
    );
  }
}
