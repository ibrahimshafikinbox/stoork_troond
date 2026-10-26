import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:troond/config/routes/app_routes.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.filterScreen);
        },
        child: SizedBox(
          width: 180,
          child: Card(
            color: AppColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    BootstrapIcons.sliders,
                    color: AppColor.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    local.filter,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
