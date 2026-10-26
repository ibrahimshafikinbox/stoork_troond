import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/auth/controller/passowrd_controller.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var passwordController = Provider.of<PasswordController>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterPwValidator(
        controller: controller,
        minLength: 6,
        lowercaseCharCount: 1,
        numericCharCount: 3,
        specialCharCount: 1,
        width: 400,
        height: 150,
        onSuccess: passwordController.onSuccess,
        successColor: AppColor.c38AE04,
      ),
    );
  }
}
