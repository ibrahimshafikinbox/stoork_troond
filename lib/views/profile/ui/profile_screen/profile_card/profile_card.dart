import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/profile/model/user_model.dart';
import 'package:troond/views/profile/services/user_services.dart';
import 'package:troond/views/profile/ui/profile_screen/profile_card/profile_card_body.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../../config/app_local/app_local.dart';
import '../../../controller/profile_controller.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    var profileController = Provider.of<ProfileController>(context);
    var local = MyLocalizations.getLocal(context);
    return SharedPref.isLogin()
        ? FutureBuilder<UserModel?>(
            future: UserServices().getUserInfo(),
            builder: (context, snapshot) {
              var cache = SharedPref.getKey(key: SharedConsts.profile);
              if (cache == null) {
                return const LoadingWidget();
              } else {
                Map data = jsonDecode(cache);
                UserModel userModel = UserModel.fromJson(data["data"]);
                var user = snapshot.hasData ? snapshot.data! : userModel;
                return ProfileCardBody(
                  isEdit: isEdit,
                  editPhoto: () {
                    profileController.updateImage(userId: user.id);
                  },
                  user: user,
                );
              }
            },
          )
        : Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.cE6EAED),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.main.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColor.main,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        local.tapToLoginOrCreateAccount,
                        style: const TextStyle(
                          color: AppColor.c1E1E1E,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        local.guestProfileHint,
                        style: const TextStyle(
                          color: AppColor.c717171,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.loginScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.main,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
