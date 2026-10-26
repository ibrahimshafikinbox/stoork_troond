import 'package:flutter/material.dart';
import '../../../../config/theme/app_color.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.onTap,
    required this.title,
  });
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColor.c121212,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColor.main,
        size: 18,
      ),
    );
  }
}
