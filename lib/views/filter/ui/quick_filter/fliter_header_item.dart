import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../config/theme/app_color.dart';

class FliterHeaderItem extends StatelessWidget {
  const FliterHeaderItem({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.cDFDFDF, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColor.c717171,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                BootstrapIcons.chevron_down,
                color: AppColor.c717171,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
