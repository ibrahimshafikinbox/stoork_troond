import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/views/auth/controller/passowrd_controller.dart';
import 'package:troond/views/auth/ui/widget/auth_text_widget.dart';
import 'package:troond/views/auth/ui/widget/header.dart';
import 'package:troond/views/auth/ui/widget/password_widget.dart';
import 'package:troond/widget/input/build_input_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    var passwordController = Provider.of<PasswordController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const SizedBox(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.mainScreen,
                (route) => false,
              );
            },
            child: Text(
              local.skip,
              style: const TextStyle(
                color: AppColor.c2B2B8D,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: authController.registerKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* header
                AuthHeaderWidget(title: local.createAnAccount),

                const SizedBox(height: 50),
                authController.errors.isNotEmpty
                    ? Text(
                        authController.errors,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.cD21318,
                        ),
                      )
                    : const SizedBox(),

                //* email
                BuildInputHeader(
                  header: local.email,
                  controller: authController.email,
                  validator: AppValidation.email(),
                  inputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                //* full name
                BuildInputHeader(
                  header: local.fullName,
                  controller: authController.name,
                  inputType: TextInputType.text,
                  validator: AppValidation.name(),
                ),

                const SizedBox(height: 10),

                BuildInputHeader(
                  header: local.password,
                  controller: authController.password,
                  validator: AppValidation.password(),
                  isObscure: authController.isObscureRegister,
                  onChange: (p0) {
                    passwordController.updatePasswordInput();
                  },
                  suffixIcon: IconButton(
                    onPressed: authController.showPasswordRegister,
                    icon: Icon(
                      authController.isObscureRegister
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.c717171,
                    ),
                  ),
                ),

                //* password
                authController.password.text.isNotEmpty
                    ? PasswordWidget(controller: authController.password)
                    : const SizedBox(),

                const SizedBox(height: 20),

                //* login btnßßßs
                authController.isRegister
                    ? const LoadingWidget()
                    : BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          authController.register(context: context);
                        },
                        text: local.createAnAccountCapital,
                      ),

                const SizedBox(height: 20),

                //* log in
                AuthTextWidget(
                  text: local.alreadyHaveAnAccount,
                  nextText: local.login,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
