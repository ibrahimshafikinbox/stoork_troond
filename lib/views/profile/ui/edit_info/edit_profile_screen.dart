import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/views/profile/controller/profile_controller.dart';
import 'package:troond/views/profile/model/user_model.dart';
import 'package:troond/views/profile/services/user_services.dart';
import 'package:troond/views/profile/ui/edit_info/edit_profile_item.dart';
import 'package:troond/views/profile/ui/profile_screen/profile_card/profile_card.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/space/grey_space.dart';
import '../../../../config/app_const/shared_const.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../data/shared_pref/shared_pref.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/dailgo/build_dailgo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);
    ProfileController profileController =
        Provider.of<ProfileController>(context);
    var local = MyLocalizations.getLocal(context);
    return FutureBuilder<UserModel?>(
      future: UserServices().getUserInfo(),
      builder: (context, snapshot) {
        var cache = SharedPref.getKey(key: SharedConsts.profile);
        if (cache == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const LoadingWidget(),
          );
        } else {
          Map data = jsonDecode(cache);
          UserModel userModel = UserModel.fromJson(data["data"]);

          var result = snapshot.hasData ? snapshot.data! : userModel;
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: profileController.isLoading
                ? const LoadingWidget()
                : SafeArea(
                    bottom: true,
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          profileController.updateInfo(result: result);
                        },
                        text: local.updateInfo,
                      ),
                    ),
                  ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* user info
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ProfileCard(isEdit: true),
                  ),
                  const SizedBox(height: 20),

                  GreySpace(hasText: true, text: local.generalInfo),

                  //* General Info
                  EditProfileItem(
                    hintText: result.fullName ?? "",
                    title: local.name,
                    icon: BootstrapIcons.pencil_square,
                    onChange: (value) {
                      profileController.newName = value;
                    },
                  ),
                  EditProfileItem(
                    hintText: result.email ?? "",
                    title: local.email,
                    icon: BootstrapIcons.pencil_square,
                    onChange: (value) {
                      profileController.newEmail = value;
                    },
                  ),
                  EditProfileItem(
                    hintText: "English",
                    title: local.preferredLanguage,
                    icon: BootstrapIcons.chevron_down,
                    readOnly: true,
                  ),

                  const SizedBox(height: 10),

                  GreySpace(hasText: true, text: local.securityNumber),

                  //* password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditProfileItem(
                        hintText: "•••••••••••",
                        title: local.password,
                        icon: null,
                        hasCard: true,
                        readOnly: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.changePasswordScreen,
                              arguments: result.id,
                            );
                          },
                          child: Text(
                            local.changePassword,
                            style: const TextStyle(
                              color: AppColor.c2B2B8D,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* phone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditProfileItem(
                        hintText: result.phoneNumber!,
                        title: local.phoneNumber,
                        icon: null,
                        hasCard: true,
                        readOnly: true,
                        controller: TextEditingController(
                          text: result.phoneNumber!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.editNumberScreen,
                              arguments: result.id,
                            );
                          },
                          child: Text(
                            local.changePhoneNumber,
                            style: const TextStyle(
                              color: AppColor.c2B2B8D,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        BuildDailgo.showDailgo(
                          context: context,
                          title: local.deleteAccount,
                          subTitle: local.deleteAccountHint,
                          btnText: local.delete,
                          onTap: () {
                            authController.deleteAccount(context);
                          },
                        );
                      },
                      child: Text(
                        local.deleteAccount,
                        style: const TextStyle(
                          color: AppColor.cD21318,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
