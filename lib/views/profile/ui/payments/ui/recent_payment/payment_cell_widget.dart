import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class PaymentCellWidget extends StatelessWidget {
  const PaymentCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColor.main,
              minimumSize: const Size(50.0, 10.0),
            ),
            onPressed: () {},
            child: const Text(
              "Buy",
              style: TextStyle(
                fontSize: 10,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
