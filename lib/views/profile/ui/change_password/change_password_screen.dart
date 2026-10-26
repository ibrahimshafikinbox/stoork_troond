import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/views/profile/controller/profile_controller.dart';
import 'package:troond/widget/input/build_input_header.dart';
import 'package:troond/widget/btn/text_btn.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    var profileController = Provider.of<ProfileController>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: profileController.passwordKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* header
                Text(
                  local.changePassword,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 50),

                BuildInputHeader(
                  header:local.oldPassword,
                  controller: profileController.oldPassword,
                  isObscure: !profileController.showPawword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      profileController.passwordObseve();
                    },
                    icon: Icon(
                      !profileController.showPawword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.c717171,
                    ),
                  ),
                ),

                BuildInputHeader(
                  header:local.newPassword,
                  controller: profileController.password,
                  isObscure: !profileController.showPawword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      profileController.passwordObseve();
                    },
                    icon: Icon(
                      !profileController.showPawword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.c717171,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //* SUBMIT
                BuildTextBtn(
                  color: AppColor.main,
                  onTap: () {
                    profileController.changePassword(context);
                  },
                  text: local.sbmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
