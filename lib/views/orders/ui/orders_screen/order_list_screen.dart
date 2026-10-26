import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/date/app_date.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/orders/helper/order_helper.dart';
import 'package:troond/views/orders/ui/orders_screen/no_orders_widgt.dart';
import 'package:troond/widget/divider/dot_divider.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../../config/app_local/app_local.dart';
import '../../model/order_model.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key, required this.orders});
  final List<OrderModel>? orders;
  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return orders!.isEmpty
        ? const NoOrdersWidget()
        : ListView.builder(
            itemCount: orders!.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var singleItem = orders![index];
              Order order = singleItem.order;
              List<OrderModelItem> orderItems = singleItem.items;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColor.cDADCE3,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              orderItems.length > 3 ? 3 : orderItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var image =
                                orderItems[index].product.images[0].path;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.productPreviewScreen,
                                  arguments: orderItems[index].product.id,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(image),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      orderItems.length > 3 && index == 2
                                          ? SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Material(
                                                color: AppColor.c000000
                                                    .withOpacity(0.20),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Center(
                                                  child: Text(
                                                    "+${orderItems.length - 3}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColor.white,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${local.orderN}: ${order.id}",
                              style: const TextStyle(
                                color: AppColor.c121212,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${local.orderAt} ${order.address.city} : ${AppDate.format(order.createdAt)}",
                              style: const TextStyle(
                                color: AppColor.c3D3D3D,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //* dot divider
                      const BuildDividerDot(),

                      const SizedBox(height: 10),

                      //* order status
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //* Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.orderStatus,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  order.status,
                                  style: TextStyle(
                                    color: OrderHelper.getStatusOrder(
                                        order.status),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            //* Items
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.items,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${orderItems.length} ${local.itemsPurchased}",
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            //* Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.price,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${order.total} ${AppStrings.currecy}",
                                  style: const TextStyle(
                                    color: AppColor.main,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            BuildTextBtn(
                              color: AppColor.main,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.orderDetailsScreen,
                                  arguments: singleItem,
                                );
                              },
                              text: local.details,
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
