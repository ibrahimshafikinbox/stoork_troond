import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/views/profile/ui/profile_screen/profile_card/profile_card.dart';
import 'package:troond/views/profile/ui/profile_screen/profile_item.dart';
import 'package:troond/widget/dailgo/build_dailgo.dart';

import '../../../../config/app_local/app_local.dart';
import '../../../../widget/bottom_sheet/bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColor.cE6EAED,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20.0, left: 20.0, top: 16.0, bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColor.c717171,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);
    MainController mainController = Provider.of<MainController>(context);
    var local = MyLocalizations.getLocal(context);
    bool isLogin = SharedPref.isLogin();
    final isSupplier = SharedPref.getSupplierId() != null;

    return Scaffold(
      backgroundColor: AppColor.cF6F6F6,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          children: [
            //* Header Profile Card
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: ProfileCard(isEdit: false),
            ),

            const SizedBox(height: 10),

            //* Account & Orders Section (Logged In Only)
            if (isLogin) ...[
              _buildSectionTitle(local.accountAndActivity),
              _buildSectionCard(
                children: [
                  ProfileItem(
                    icon: BootstrapIcons.person,
                    iconColor: AppColor.main,
                    iconBgColor: AppColor.main.withOpacity(0.08),
                    text: local.profile,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.editProfileScreen,
                      );
                    },
                  ),
                  const Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 16,
                      color: AppColor.cF1F1F1),
                  ProfileItem(
                    icon: BootstrapIcons.box_seam,
                    iconColor: const Color(0xff29296E),
                    iconBgColor: const Color(0xff29296E).withOpacity(0.08),
                    text: local.orders,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.ordersScreen);
                    },
                  ),
                  const Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 16,
                      color: AppColor.cF1F1F1),
                  ProfileItem(
                    icon: Icons.place_outlined,
                    iconColor: const Color(0xff38AE04),
                    iconBgColor: const Color(0xff38AE04).withOpacity(0.08),
                    text: local.address,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.addressScreen);
                    },
                  ),
                  const Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 16,
                      color: AppColor.cF1F1F1),
                  ProfileItem(
                    icon: BootstrapIcons.heart,
                    iconColor: const Color(0xffFA4040),
                    iconBgColor: const Color(0xffFA4040).withOpacity(0.08),
                    text: local.favorite,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.favScreen,
                        arguments: true,
                      );
                    },
                  ),
                  const Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 16,
                      color: AppColor.cF1F1F1),
                  ProfileItem(
                    icon: BootstrapIcons.clipboard_check,
                    iconColor: const Color(0xffFAC12E),
                    iconBgColor: const Color(0xffFAC12E).withOpacity(0.12),
                    text: local.myList,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.myListScreen);
                    },
                  ),
                ],
              ),

              //* Supplier Hub Section
              _buildSectionTitle(local.merchantAndSupplierHub),
              _buildSectionCard(
                children: [
                  ProfileItem(
                    icon: isSupplier
                        ? BootstrapIcons.speedometer2
                        : BootstrapIcons.shop,
                    iconColor: const Color(0xffFF6801),
                    iconBgColor: const Color(0xffFF6801).withOpacity(0.1),
                    text: isSupplier ? local.dashboard : local.beSubblier,
                    treadingWidget:
                        isSupplier ? local.verifiedSupplier : local.joinNow,
                    onTap: () {
                      if (isSupplier) {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.supplierProductScreen);
                      } else {
                        Navigator.of(context).pushNamed(AppRoutes.beSupplier);
                      }
                    },
                  ),
                ],
              ),
            ],

            //* Preferences & Public Section
            _buildSectionTitle(local.settingsAndHelp),
            _buildSectionCard(
              children: [
                ProfileItem(
                  icon: BootstrapIcons.translate,
                  iconColor: const Color(0xff29296E),
                  iconBgColor: const Color(0xff29296E).withOpacity(0.08),
                  text: local.language,
                  treadingWidget: mainController.language.name,
                  onTap: () {
                    CustomBottomSheet.showLanguage(context: context);
                  },
                ),
                const Divider(
                    height: 1,
                    indent: 60,
                    endIndent: 16,
                    color: AppColor.cF1F1F1),
                ProfileItem(
                  icon: BootstrapIcons.question_circle,
                  iconColor: const Color(0xff7E859B),
                  iconBgColor: const Color(0xff7E859B).withOpacity(0.1),
                  text: local.help,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.helpScreen);
                  },
                ),
              ],
            ),

            //* Logout Button Section (Logged In Only)
            if (isLogin) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      BuildDailgo.showDailgo(
                        context: context,
                        title: local.logout,
                        subTitle: local.logoutHint,
                        btnText: local.logout,
                        onTap: () {
                          authController.logout(context);
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffFA4040).withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xffFA4040).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Color(0xffFA4040),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              local.logout,
                              style: const TextStyle(
                                color: Color(0xffFA4040),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Color(0xffFA4040),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


            // ProfileItem(
            //   icon: BootstrapIcons.chat_square_text,
            //   text: "Inbox",
            //   onTap: () {
            //     Navigator.of(context).pushNamed(
            //       AppRoutes.messageScreen,
            //       arguments: true,
            //     );
            //   },
            // ),

            // ProfileItem(
            //   icon: BootstrapIcons.chat_square_text,
            //   text: "Inbox",
            //   onTap: () {
            //     Navigator.of(context).pushNamed(
            //       AppRoutes.messageScreen,
            //       arguments: true,
            //     );
            //   },
            // ),


            // ProfileItem(
            //   icon: BootstrapIcons.translate,
            //   text: "Language",
            //   onTap: () {
            //     CustomBottomSheet.showLanguage(context: context);
            //   },
            //   treadingWidget: const Text("ENGLISH"),
            // ),

            // ProfileItem(
            //   icon: BootstrapIcons.coin,
            //   text: "Payment",
            //   onTap: () {
            //     Navigator.of(context).pushNamed(AppRoutes.paymentsScreen);
            //   },
            // ),