import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/input/build_input_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../../config/valid/app_validation.dart';

class ForgetPawwordScreen extends StatelessWidget {
  const ForgetPawwordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: authController.forgetPasswordKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* header
                Text(
                  local.forgotYourPassword,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 50),

                //* svg
                const SvgWidget(svgName: "forget_password.svg"),

                const SizedBox(height: 20),

                //* text
                SizedBox(
                  width: 300,
                  child: Text(
                    local.pleaseEnterYourEmai,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor.c3D3D3D,
                    ),
                  ),
                ),

                //* email
                BuildInputHeader(
                  header: local.email,
                  controller: authController.emailForgetPassword,
                  validator: AppValidation.email(),
                  inputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                //* SEND
                BuildTextBtn(
                  color: AppColor.main,
                  onTap: () {
                    authController.forgetPassword(context: context);
                  },
                  text: local.send,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
