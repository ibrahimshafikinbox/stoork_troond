import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColor.c121212,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }
}
