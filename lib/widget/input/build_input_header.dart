import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

import 'build_input.dart';

class BuildInputHeader extends StatelessWidget {
  const BuildInputHeader({
    super.key,
    required this.header,
    this.controller,
    this.onChange,
    this.isObscure = false,
    this.inputType = TextInputType.text,
    this.suffixIcon,
    this.validator,
  });
  final String header;
  final TextEditingController? controller;
  final dynamic Function(String)? onChange;
  final bool isObscure;
  final TextInputType inputType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          header,
          style: const TextStyle(
            color: AppColor.c636363,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      subtitle: BuildInput(
        controller: controller,
        onChange: onChange,
        isObscure: isObscure,
        inputType: inputType,
        suffixIcon: suffixIcon,
        validator: validator,
      ),
    );
  }
}
