import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/widget/input/build_input_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../widget/auth_text_widget.dart';
import '../widget/header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
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
        key: authController.loginKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* header
                AuthHeaderWidget(title: local.login),

                const SizedBox(height: 50),

                //* email
                BuildInputHeader(
                  header: local.email,
                  controller: authController.emailLogin,
                  validator: AppValidation.email(),
                  inputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                //* password
                BuildInputHeader(
                  header: local.password,
                  controller: authController.passwordLogin,
                  validator: AppValidation.password(),
                  isObscure: authController.isObscureLogin,
                  suffixIcon: IconButton(
                    onPressed: authController.showPasswordLogin,
                    icon: Icon(
                      authController.isObscureLogin
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.c717171,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //* forget password
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.forgetPasswordScreen,
                    );
                  },
                  child: Text(
                    local.forgotYourPassword,
                    style: const TextStyle(
                      color: AppColor.c29296E,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //* login btn
                authController.isLogin
                    ? const LoadingWidget()
                    : BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          authController.login(context: context);
                        },
                        text: local.lognCapital,
                      ),

                const SizedBox(height: 40),

                //* register
                AuthTextWidget(
                  text: local.dontHaveAnAccount,
                  nextText: local.signUp,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen);
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
