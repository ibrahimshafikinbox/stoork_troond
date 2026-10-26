import 'package:flutter/material.dart';
import '../../config/app_local/app_local.dart';
import '../../config/theme/app_color.dart';

class MoreBtn extends StatelessWidget {
  const MoreBtn({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        ),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 12,
          color: AppColor.main,
        ),
        label: Text(
          local.seeAll,
          style: const TextStyle(
            color: AppColor.main,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
