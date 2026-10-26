import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/logo/logo_svg.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoSvg(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const Text(
            "Payment",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: AppColor.c191919,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColor.cDADCE3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PaymentItem(
                        svg: "money-send.svg",
                        title: "Payment processing",
                        total: "0.00",
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.paymentProcessingScreen,
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: AppColor.cDADCE3),
                      ),
                      PaymentItem(
                        svg: "bank.svg",
                        title: "Payment not matched to order",
                        total: "0.00",
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.recentPaymentScreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    super.key,
    required this.svg,
    required this.title,
    required this.total,
    required this.onTap,
  });
  final String svg;
  final String title;
  final String total;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgWidget(svgName: svg),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColor.c717171,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "USD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.c121212,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                total,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColor.c717171,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
