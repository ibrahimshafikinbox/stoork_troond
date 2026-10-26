import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    this.icon,
    required this.text,
    required this.onTap,
    this.treadingWidget,
    this.iconColor,
    this.iconBgColor,
  });

  final String text;
  final IconData? icon;
  final Function() onTap;
  final String? treadingWidget;
  final Color? iconColor;
  final Color? iconBgColor;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColor.main;
    final effectiveIconBgColor = iconBgColor ?? AppColor.main.withOpacity(0.08);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: effectiveIconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: effectiveIconColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: AppColor.c1E1E1E,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.5,
                  ),
                ),
              ),
              if (treadingWidget != null && treadingWidget!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.cE6EAED,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    treadingWidget!,
                    style: const TextStyle(
                      color: AppColor.c29296E,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: AppColor.cF6F6F6,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11,
                  color: AppColor.c717171,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

