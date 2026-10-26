import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

import '../../config/app_local/app_local.dart';

class BuildDailgo {
  // confirm dailgo
  // static confirmDailgo({required BuildContext context}) {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.warning,
  //     text: 'You just broke protocol',
  //   );
  // }

  static showDailgo({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String btnText,
    required Function() onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        var local = MyLocalizations.getLocal(context);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 250,
            child: Material(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          BootstrapIcons.exclamation_octagon,
                          color: AppColor.cFA4040,
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColor.c3D3D3D,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 400,
                          child: Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColor.c626A83,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //* actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DailgoBtn(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: local.cancel,
                        textColor: AppColor.c121212,
                      ),
                      DailgoBtn(
                        onTap: onTap,
                        text: btnText,
                        textColor: AppColor.cD21318,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DailgoBtn extends StatelessWidget {
  const DailgoBtn({
    super.key,
    required this.onTap,
    required this.text,
    required this.textColor,
    this.isAction = false,
  });
  final String text;
  final Color textColor;
  final Function() onTap;
  final bool isAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: const BorderSide(color: AppColor.cEBEBEB),
              right: !isAction
                  ? BorderSide.none
                  : const BorderSide(color: AppColor.cEBEBEB),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
