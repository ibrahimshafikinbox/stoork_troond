import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/widget/input/build_input.dart';

class EditProfileItem extends StatelessWidget {
  const EditProfileItem({
    super.key,
    this.onTap,
    required this.hintText,
    required this.title,
    required this.icon,
    this.hasCard = false,
    this.controller,
    this.readOnly = false,
    this.onChange,
  });
  final String title;
  final String hintText;
  final Function()? onTap;
  final IconData? icon;
  final bool hasCard;
  final TextEditingController? controller;
  final bool readOnly;
  final dynamic Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.c3D3D3D,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      subtitle: InkWell(
        onTap: onTap,
        child: Card(
          color: hasCard == true ? AppColor.cF1F1F1 : null,
          child: BuildInput(
            readOnly: readOnly,
            onChange: onChange,
            hintText: hintText,
            controller: controller,
            suffixIcon: Icon(
              icon,
              color: AppColor.cDBDBDB,
            ),
          ),
        ),
      ),
    );
  }
}
