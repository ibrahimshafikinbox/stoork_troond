import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/btn/text_btn.dart';

import '../../../../config/app_local/app_local.dart';

class NoOrdersWidget extends StatelessWidget {
  const NoOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const SvgWidget(svgName: "no_order.svg"),

          const SizedBox(height: 50),

          //* no order text
          Text(
            local.youHaveNoPreviousOrders,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColor.c717171,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 400,
            child: Text(
              local.noOrderHint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColor.c717171,
              ),
            ),
          ),

          const SizedBox(height: 70),

          BuildTextBtn(
            color: AppColor.main,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.mainScreen);
            },
            text: local.continueShopping,
          ),
        ],
      ),
    );
  }
}
