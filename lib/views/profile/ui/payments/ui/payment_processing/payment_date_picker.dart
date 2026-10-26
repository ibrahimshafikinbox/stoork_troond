import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_color.dart';

class PaymentDatePicker extends StatelessWidget {
  const PaymentDatePicker({
    super.key,
    required this.onTap,
    required this.title,
  });
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColor.cEBEBEB),
            borderRadius: BorderRadius.circular(10),
          ),
          minLeadingWidth: 0,
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xffBEBEBE),
            ),
          ),
          trailing: const Icon(
            Icons.calendar_month_rounded,
            size: 25,
          ),
        ),
      ),
    );
  }
}
