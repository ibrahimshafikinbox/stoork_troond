// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:troond/config/app_media/app_media.dart';
import 'package:troond/views/profile/model/user_model.dart';
import 'package:troond/views/profile/services/user_services.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../../../config/app_local/app_local.dart';

class ProfileController extends ChangeNotifier {
  UserServices userServices = UserServices();

  bool isLoading = false;
  Future updateImage({required int userId}) async {
    await AppMedia().pickImage().then((value) async {
      if (value != null) {
        isLoading = true;
        notifyListeners();
        await userServices.updateImage(userId: userId, image: value.path);
        isLoading = false;
        notifyListeners();
      }
    });
  }

  String newName = "";
  String newEmail = "";
  Future updateInfo({required UserModel result}) async {
    isLoading = true;
    notifyListeners();
    await userServices.updateInfo(
      userId: result.id,
      name: newName.isEmpty ? null : newName,
      email: newEmail.isEmpty ? null : newEmail,
    );
    isLoading = false;
    notifyListeners();
  }

  bool isUpdatePhone = false;
  final phoneKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  String cityKey = "";
  Future updatePhone({
    required int userId,
    required BuildContext context,
  }) async {
    var local = MyLocalizations.getLocal(context);
    if (cityKey.isEmpty) {
      BuildToast.success(title: local.chooseCode);
    } else {
      if (phoneKey.currentState!.validate()) {
        isUpdatePhone = true;
        notifyListeners();
        await userServices.updatePhone(
          userId: userId,
          phone: cityKey + phone.text,
        );
        isUpdatePhone = false;
        cityKey = "";
        phone.clear;
        notifyListeners();
        Navigator.pop(context);
      }
    }
  }

  final passwordKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  bool showPawword = false;
  passwordObseve() {
    showPawword = !showPawword;
    notifyListeners();
  }

  Future changePassword(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    if (passwordKey.currentState!.validate()) {
      if (password.text == oldPassword.text) {
        isUpdatePhone = true;
        notifyListeners();
        await userServices.updatePassword(
          oldPassword: oldPassword.text,
          password: password.text,
        );
        isUpdatePhone = true;
        notifyListeners();
        oldPassword.clear();
        password.clear();
        BuildToast.success(title:local.done);
      } else {
        BuildToast.success(title:local.passwordsDoNOTMatch);
      }
    }
  }
}
