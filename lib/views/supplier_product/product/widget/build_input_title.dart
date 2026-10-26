import 'package:flutter/material.dart';
import 'package:troond/config/valid/app_validation.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widget/input/build_input.dart';

class BuildInputTitle extends StatelessWidget {
  const BuildInputTitle({
    super.key,
    required this.controller,
    required this.title,
  });
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.c3D3D3D,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: BuildInput(
        controller: controller,
        validator: AppValidation.required(),
      ),
    );
  }
}
