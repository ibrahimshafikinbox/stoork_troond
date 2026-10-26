import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../widget/input/build_input_header.dart';
import '../../controller/passowrd_controller.dart';
import '../widget/password_widget.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);
    var passwordController = Provider.of<PasswordController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: authController.otpKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* header
                Text(
                  local.verifyYourPassword,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 50),

                //* svg
                const SvgWidget(svgName: "confirm_apssword.svg"),

                const SizedBox(height: 20),

                //* text
                SizedBox(
                  width: 300,
                  child: Text(
                    local.pleaseEnterTheFourDigitCode,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor.c3D3D3D,
                    ),
                  ),
                ),

                //* otp code
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40,
                    spaceBetween: 10,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: AppColor.main,
                      disabledBorderColor: AppColor.main,
                      enabledBorderColor: AppColor.main,
                      focusBorderColor: AppColor.main,
                    ),
                    textFieldAlignment: MainAxisAlignment.center,
                    fieldStyle: FieldStyle.underline,
                    keyboardType: TextInputType.phone,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(),
                    controller: OtpFieldController(),
                    onChanged: (value) {},
                    onCompleted: (pin) {
                      authController.otp.text = pin;
                    },
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                BuildInputHeader(
                  header: local.newPassword,
                  controller: authController.passworForgetPassword,
                  validator: AppValidation.password(),
                  isObscure: authController.isObscureOtp,
                  suffixIcon: IconButton(
                    onPressed: authController.showPasswordOtp,
                    icon: const Icon(
                      Icons.visibility_off,
                      color: AppColor.c717171,
                    ),
                  ),
                ),
                PasswordWidget(
                  controller: authController.passworForgetPassword,
                ),

                const Divider(),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    authController.resendCode(context);
                  },
                  child: Text(
                    local.resendCode,
                    style: const TextStyle(
                      color: AppColor.c29296E,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //* SEND
                authController.isOtp
                    ? const LoadingWidget()
                    : BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          if (passwordController.isSuccess) {
                            authController.sendForgetPassword(context: context);
                          }
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
