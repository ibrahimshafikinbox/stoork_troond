import 'package:flutter/material.dart';
import 'package:troond/views/profile/ui/payments/ui/payment_processing/payment_date_picker.dart';
import 'package:troond/views/profile/ui/payments/ui/payment_processing/status_cell.dart';
import 'package:troond/widget/cell/build_cell.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/logo/logo_svg.dart';
import '../../../../../../config/theme/app_color.dart';

class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoSvg(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Payment processing",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColor.c191919,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColor.cDADCE3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            //* Date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: AppColor.c121212,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PaymentDatePicker(
                                      onTap: () {},
                                      title: "Start Time",
                                    ),
                                    PaymentDatePicker(
                                      onTap: () {},
                                      title: "Start Time",
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //* Amount
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: AppColor.c121212,
                                  ),
                                ),
                                SizedBox(height: 5),
                                BuildInput(
                                  inputType: TextInputType.number,
                                  hintText: "Amount",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Row(
                            children: [
                              BuildCell(
                                text: 'ID',
                                isHeader: true,
                              ),
                              BuildCell(
                                text: 'Time Send',
                                flex: 3,
                                isHeader: true,
                              ),
                              BuildCell(
                                text: 'Time Arrived',
                                flex: 3,
                                isHeader: true,
                              ),
                              BuildCell(
                                text: 'status',
                                flex: 2,
                                isHeader: true,
                              ),
                            ],
                          ),
                          for (int i = 0; i < 20; i++)
                            Row(
                              children: [
                                BuildCell(
                                  text: '${i + 1}',
                                ),
                                const BuildCell(
                                  text: '25 Mar 2023',
                                  flex: 3,
                                ),
                                const BuildCell(
                                  text: '30 Mar 2023',
                                  flex: 3,
                                ),
                                const StatusCellWidget(),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
