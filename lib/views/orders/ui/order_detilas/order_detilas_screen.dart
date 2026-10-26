import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/date/app_date.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/views/orders/helper/order_helper.dart';
import 'package:troond/views/orders/model/order_model.dart';
import 'package:troond/views/orders/services/orders_services.dart';
import 'package:troond/widget/btn/outline_btn.dart';
import 'package:troond/widget/divider/dot_divider.dart';
import 'package:troond/widget/text/build_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../product/model/product_preview.dart';
import 'order_tracking_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    var order = orderModel.order;
    var ordersItem = orderModel.items;
    CartController cartController = Provider.of<CartController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* order tracking
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 50),
                    OrderTrackingWidget(
                      index: 0,
                      text: local.process,
                      svgName: "order/process1.svg",
                    ),
                    OrderTrackingWidget(
                      index: 1,
                      text: local.delivery,
                      svgName: "order/delivery1.svg",
                    ),
                    OrderTrackingWidget(
                      index: 2,
                      text: local.arriving,
                      svgName: "order/arriving1.svg",
                    ),
                    OrderTrackingWidget(
                      index: 3,
                      text: local.success,
                      svgName: "order/success1.svg",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            //* Product
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildHeader(text: local.product),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ordersItem.length,
                    itemBuilder: (context, index) {
                      var orderItem = ordersItem[index];
                      ProductPreview product = orderItem.product;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.productPreviewScreen,
                            arguments: orderItem.product.id,
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColor.cC3C3C3.withOpacity(0.50),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: AppColor.cDADCE3,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image(
                                    height: 100,
                                    width: 100,
                                    image: CachedNetworkImageProvider(product.images[0].path),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            color: AppColor.c3D3D3D,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        product.details.isNotEmpty
                                            ? Text(
                                                "${local.size}: ${product.details[0].size} ${local.color}: ${product.details[0].color}",
                                                style: const TextStyle(
                                                  color: AppColor.c626A83,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${product.price} ${AppStrings.currecy}",
                                          style: const TextStyle(
                                            color: AppColor.main,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildHeader(text: local.shippingDetails),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColor.cDADCE3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              BuildShippingItem(
                                title: local.dateShipping,
                                value: AppDate.format(order.createdAt),
                              ),
                              BuildShippingItem(
                                title: local.shipping,
                                value: "POS Reggular",
                              ),
                              // const BuildShippingItem(
                              //   title: "No. Resi",
                              //   value: "25416516384",
                              // ),
                              BuildShippingItem(
                                title: local.address,
                                value: order.address.mainAdress,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildHeader(text: local.paymentDetails),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColor.cDADCE3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              BuildShippingItem(
                                title: "${local.items} (${ordersItem.length})",
                                value: order.total, //!  shipping cost
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
                                      text: order.total,
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
                  const SizedBox(height: 10),

                  //* cancel order
                  orderModel.order.status == OrderHelper.delivered
                      ? SafeArea(
                          top: false,
                          child: Row(
                            children: [
                              Expanded(
                                child: BuildTextButton(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.reviewScreen,
                                      arguments: orderModel,
                                    );
                                  },
                                  text: local.giveUsFeedback,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: BuildOutlineBtn(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.helpScreen,
                                    );
                                  },
                                  text: "Return Order",
                                ),
                              ),
                            ],
                          ),
                        )
                      : FutureBuilder<OrderModel?>(
                          future: OrdersServices()
                              .getSingleOrders(orderModel.order.id),
                          builder: (context, snapshot) {
                            String status = snapshot.hasData
                                ? snapshot.data!.order.status
                                : "";
                            return status == OrderHelper.canceled
                                ? const SizedBox()
                                : SafeArea(
                                    top: false,
                                    child: BuildTextBtn(
                                      color: AppColor.cD21318,
                                      onTap: () {
                                        cartController.changeOrderStatus(
                                          orderId: orderModel.order.id,
                                          status: OrderHelper.canceled,
                                        );
                                      },
                                      text: local.cancelOrder,
                                    ),
                                  );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildShippingItem extends StatelessWidget {
  const BuildShippingItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColor.c223263,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColor.c223263,
                fontWeight: FontWeight.w600,
                wordSpacing: 3,
                height: 2,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
