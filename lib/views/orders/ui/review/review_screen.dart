import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/date/app_date.dart';
import '../../../../config/app_local/app_local.dart';
import '../../model/order_model.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: orderModel.items.length,
          itemBuilder: (context, index) {
            var orderItem = orderModel.items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: AppColor.cDADCE3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productPreviewScreen,
                                arguments: orderItem.product.id,
                              );
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    orderItem.product.images[0].path,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${local.orderN}: ${orderModel.order.id}",
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColor.main,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.reviewProductScreen,
                                      arguments: orderItem,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.star,
                                    color: AppColor.white,
                                    size: 14,
                                  ),
                                  label: Text(
                                    local.productReview,
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "${local.orderAt} cairo : ${AppDate.format(orderModel.order.createdAt)}",
                        style: const TextStyle(
                          color: AppColor.c3D3D3D,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 7),
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
                            orderModel.order.status,
                            style: const TextStyle(
                              color: AppColor.main,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
