import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:troond/config/theme/app_color.dart';

class BuildInput extends StatelessWidget {
  const BuildInput({
    Key? key,
    this.hintText,
    this.onChange,
    this.isObscure = false,
    this.controller,
    this.validator,
    this.inputType,
    this.iconButton,
    this.suffixIcon,
    this.maxLines = 1,
    this.readOnly = false,
    this.inputFormatters,
    this.borderColor = AppColor.cDBDBDB,
  }) : super(key: key);
  final String? hintText;
  final Function(String)? onChange;
  final bool isObscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final Widget? iconButton;
  final Widget? suffixIcon;
  final int maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      maxLines: maxLines,
      keyboardType: inputType,
      obscureText: isObscure,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: hintText,
        prefixIcon: iconButton,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange,
    );
  }
}
