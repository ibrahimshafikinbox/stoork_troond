import 'package:flutter/material.dart';
import 'package:troond/config/app_assets/app_assets.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/orders/model/order_model.dart';
import 'package:troond/views/orders/services/orders_services.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../config/app_local/app_local.dart';
import '../../../widget/divider/dot_divider.dart';
import '../../../widget/text/build_header.dart';
import '../../orders/ui/order_detilas/order_detilas_screen.dart';

class CheckoutOrderScreen extends StatelessWidget {
  const CheckoutOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<OrderModel>>(
        future: OrdersServices().getOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          } else {
            var order = snapshot.data![snapshot.data!.length - 1];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    local.thankYouForOrderFrom,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.c121212,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Image(
                    image: AssetImage(
                      "${AppAssets.imgPath}checkout_done.png",
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      style: const TextStyle(height: 1.3),
                      TextSpan(
                        children: [
                          TextSpan(text: local.yourOrderIsBeingProcessed),
                          const TextSpan(
                            text: 'mahmoudkjs@gmail.com ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: local.onceYourOrderIsConfirmed),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Image(
                    image: AssetImage(
                      "${AppAssets.imgPath}checkout_process.png",
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildHeader(text: local.shippingDetails),
                        const SizedBox(height: 10),
                        Card(
                          color: AppColor.cEBF0FF,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                BuildShippingItem(
                                  title: local.dateShipping,
                                  value: "January 25, 2023",
                                ),
                                BuildShippingItem(
                                  title: local.dateShopping,
                                  value: "25416516384",
                                ),
                                BuildShippingItem(
                                  title: local.address,
                                  value: order.order.address.mainAdress,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildHeader(text: local.paymentDetails),
                        const SizedBox(height: 10),
                        Card(
                          color: AppColor.cEBF0FF,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                BuildShippingItem(
                                  title:
                                      "${local.items} (${order.items.length})",
                                  value: order.order.total, //!  shipping cost
                                ),
                                BuildShippingItem(
                                  title: local.delivery,
                                  value: "0.00", //!  shipping cost
                                ),
                                BuildShippingItem(
                                  title: local.discount,
                                  value: "0.00",
                                ),
                                const BuildDividerDot(),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BuildHeader(text: local.total),
                                      BuildHeader(
                                        text: order.order.total,
                                        textColor: AppColor.main,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SafeArea(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColor.main,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.mainScreen,
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      local.startShopping,
                                      style: const TextStyle(
                                        color: AppColor.main,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColor.main),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.ordersScreen);
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      local.trackTheOrder,
                                      style: const TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
