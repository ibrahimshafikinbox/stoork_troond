// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/auth/services/auth_services.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../../../config/app_local/app_local.dart';

class AuthController extends ChangeNotifier {
  AuthServices authServices = AuthServices();

  //* register
  bool isRegister = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  final registerKey = GlobalKey<FormState>();
  bool isObscureRegister = true;

  showPasswordRegister() {
    isObscureRegister = !isObscureRegister;
    notifyListeners();
  }

  String errors = "";
  Future register({required BuildContext context}) async {
    if (registerKey.currentState!.validate()) {
      isRegister = true;
      notifyListeners();
      print("\n=======================================================");
      print(
          "📝 [AuthController] 📤 Attempting registration for email: ${email.text}");
      Map result = await authServices.register(
        name: name.text,
        email: email.text,
        password: password.text,
      );
      print("📡 [AuthController] 📥 Registration Response Payload: $result");

      if (result.containsKey("success") && result["success"] == true) {
        isRegister = false;
        notifyListeners();

        String? extractedToken;
        if (result["data"] != null &&
            result["data"] is Map &&
            result["data"]["token"] != null) {
          extractedToken = result["data"]["token"].toString();
        } else if (result["token"] != null) {
          extractedToken = result["token"].toString();
        } else if (result["access_token"] != null) {
          extractedToken = result["access_token"].toString();
        }

        if (extractedToken != null && extractedToken.isNotEmpty) {
          await SharedPref.setToken(extractedToken);
          print(
              "🔑 [AuthController] Token stored after register: ${extractedToken.substring(0, extractedToken.length > 15 ? 15 : extractedToken.length)}...");
        }

        if (result["data"] != null && result["data"] is Map) {
          if (result["data"]["user"] != null &&
              result["data"]["user"]["id"] != null) {
            await SharedPref.setUserId(result["data"]["user"]["id"]);
          }
          if (result["data"]["user"] != null) {
            await SharedPref.setUserInfo(jsonEncode(result["data"]["user"]));
          }
        }
        print("=======================================================\n");

        notifyListeners();
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainScreen,
          (route) => false,
        );
      } else {
        isRegister = false;
        errors = result.values.isNotEmpty
            ? result.values.first.toString()
            : "فشل التسجيل";
        print("❌ [AuthController] Registration failed: $errors");
        print("=======================================================\n");
        notifyListeners();
        await Future.delayed(const Duration(seconds: 5));
        errors = "";
        notifyListeners();
      }
    }
  }

  //* login
  bool isLogin = false;
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  bool isObscureLogin = true;

  showPasswordLogin() {
    isObscureLogin = !isObscureLogin;
    notifyListeners();
  }

  bool isSuccess = false;
  Future login({required BuildContext context}) async {
    if (loginKey.currentState!.validate()) {
      isLogin = true;
      notifyListeners();
      print("\n=======================================================");
      print(
          "🔐 [AuthController] 📤 Attempting login for email: ${emailLogin.text}");
      Map result = await authServices.login(
        email: emailLogin.text,
        password: passwordLogin.text,
      );
      print("📡 [AuthController] 📥 Login Response Payload: $result");

      if (result["success"] == true) {
        isLogin = false;
        emailLogin.clear();
        passwordLogin.clear();

        String? extractedToken;
        if (result["data"] != null &&
            result["data"] is Map &&
            result["data"]["token"] != null) {
          extractedToken = result["data"]["token"].toString();
        } else if (result["token"] != null) {
          extractedToken = result["token"].toString();
        } else if (result["access_token"] != null) {
          extractedToken = result["access_token"].toString();
        }

        if (extractedToken != null && extractedToken.isNotEmpty) {
          await SharedPref.setToken(extractedToken);
          print(
              "🔑 [AuthController] Token successfully stored: ${extractedToken.substring(0, extractedToken.length > 15 ? 15 : extractedToken.length)}...");
        } else {
          print(
              "⚠️ [AuthController] Login returned success but NO TOKEN was found in response payload!");
        }

        if (result["data"] != null && result["data"] is Map) {
          if (result["data"]["user"] != null &&
              result["data"]["user"]["id"] != null) {
            await SharedPref.setUserId(result["data"]["user"]["id"]);
          }
          if (result["data"]["user"] != null) {
            await SharedPref.setUserInfo(jsonEncode(result["data"]["user"]));
          }
          if (result["data"]["suppliers"] != null &&
              result["data"]["suppliers"]["id"] != null) {
            await SharedPref.setSupplierId(result["data"]["suppliers"]["id"]);
          }
        }
        print("=======================================================\n");

        notifyListeners();
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainScreen,
          (route) => false,
        );
      } else {
        isLogin = false;
        notifyListeners();
        String errorMsg = result["data"]?["messaege"] ??
            result["message"] ??
            "بيانات الدخول غير صحيحة";
        print("❌ [AuthController] Login failed with message: $errorMsg");
        print("=======================================================\n");
        BuildToast.error(title: errorMsg);
      }
    }
  }

  //* forget password
  TextEditingController emailForgetPassword = TextEditingController();
  final forgetPasswordKey = GlobalKey<FormState>();
  bool isForgetPassword = false;

  Future forgetPassword({required BuildContext context}) async {
    if (forgetPasswordKey.currentState!.validate()) {
      isForgetPassword = true;
      notifyListeners();
      Map result = await authServices.forgetPasword(
        email: emailForgetPassword.text,
      );
      if (result.containsKey("success") && result["success"] == true) {
        isForgetPassword = false;
        notifyListeners();
        Navigator.of(context).pushNamed(AppRoutes.confirmPasswordScreen);
      } else {
        var local = MyLocalizations.getLocal(context);
        BuildToast.success(title: local.error);
        isForgetPassword = false;
        notifyListeners();
      }
    }
  }

  Future resendCode(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    Map result = await authServices.forgetPasword(
      email: emailForgetPassword.text,
    );
    if (result.containsKey("success") && result["success"] == true) {
      BuildToast.success(title: local.checkYourEmail);
    } else {
      BuildToast.success(title: local.error);
    }
  }

  bool isOtp = false;
  final otpKey = GlobalKey<FormState>();
  TextEditingController passworForgetPassword = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool isObscureOtp = true;

  showPasswordOtp() {
    isObscureOtp = !isObscureOtp;
    notifyListeners();
  }

  Future sendForgetPassword({required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    if (otpKey.currentState!.validate()) {
      isOtp = true;
      notifyListeners();
      Map result = await authServices.sendOtpForgetPassword(
        email: emailForgetPassword.text,
        code: otp.text,
        password: passworForgetPassword.text,
      );
      if (result.containsKey("success") && result["success"] == true) {
        isOtp = false;
        notifyListeners();
        Navigator.pushNamed(context, AppRoutes.loginScreen);
        BuildToast.success(title: local.passwordUpdated);
      } else {
        isOtp = false;
        notifyListeners();
        BuildToast.success(title: local.error);
      }
    }
  }

  //* logout
  Future logout(BuildContext context) async {
    await SharedPref.clear();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  //* delet account
  Future deleteAccount(BuildContext context) async {
    await authServices.deleteAccount();
    await SharedPref.clear();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginScreen,
      (route) => false,
    );
  }
}
