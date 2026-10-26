import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';

import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../widget/btn/text_btn.dart';
import '../../../widget/images/svg_widget.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key, required this.hasLeading});
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    var mainController = Provider.of<MainController>(context);
    var local = MyLocalizations.getLocal(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SvgWidget(svgName: "empty_cart.svg"),
        const SizedBox(height: 10),
        Text(
          local.yourShoppingCartLooksEmpty,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: AppColor.c121212,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          local.whatAreYouWaitingFor,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColor.c717171,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 10,
          ),
          child: BuildTextBtn(
            color: AppColor.main,
            onTap: () {
              if (hasLeading == true) {
                Navigator.of(context).pushNamed(AppRoutes.mainScreen);
              } else {
                mainController.changeIndex(0, context);
              }
            },
            text: local.startShopping,
          ),
        ),
      ],
    );
  }
}
