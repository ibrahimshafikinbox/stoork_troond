import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

import '../../../../../../../config/app_local/app_local.dart';

class MaterialCottonWidget extends StatelessWidget {
  const MaterialCottonWidget({super.key, required this.material});
  final String material;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        // borderRadius: BorderRadius.circular(5),
        color: AppColor.cFAC12E.withOpacity(0.20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "${local.material} $material",
              style: const TextStyle(
                color: AppColor.c000000,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
