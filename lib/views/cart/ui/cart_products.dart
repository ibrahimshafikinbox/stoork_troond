import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/cart/model/product_cart.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../widget/images/svg_widget.dart';
import '../controller/cart_controller.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    super.key,
    required this.data,
    required this.cartController,
  });
  final List<ProductCart> data;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return ListView.builder(
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = data[index];
        int price = item.product!.price;
        int newPrice = price * item.count;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColor.c000000.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                ),
              ],
              color: AppColor.white,
              border: Border.all(color: AppColor.cDADCE3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.productPreviewScreen,
                          arguments: item.product!.id,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          height: 130,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          image: CachedNetworkImageProvider(item.product!.images[0].path),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          item.product!.name,
                                          style: const TextStyle(
                                            color: AppColor.c121212,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      RateCard(product: item.product!),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //*
                                  Text(
                                    item.product!.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColor.c121212,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Checkbox(
                                        value: item.addToCart,
                                        checkColor: AppColor.white,
                                        activeColor: AppColor.main,
                                        focusColor: AppColor.main,
                                        side: const BorderSide(
                                          color: AppColor.cDADCE3,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            item.addToCart = value!;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                                cartController.isAdding == item.id
                                    ? const LoadingWidget()
                                    : InkWell(
                                        onTap: () {
                                          cartController.delete(
                                            id: item.id,
                                            context: context,
                                          );
                                        },
                                        child: const SvgWidget(
                                          svgName: "trash.svg",
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        //* info
                        item.detail == null
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Text(
                                    "${local.size} : ${item.detail!.size}",
                                    style: const TextStyle(
                                      color: AppColor.c717171,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "${local.color} : ${item.detail!.color}",
                                    style: const TextStyle(
                                      color: AppColor.c717171,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 45,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppColor.cDADCE3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            cartController.updateCount(
                                              cardId: item.id,
                                              isAdd: false,
                                              count: item.count,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: AppColor.cDDDDDD,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: const Color(0xffFA652E)
                                            .withOpacity(0.20),
                                        child: Text(
                                          item.count.toString(),
                                          style: const TextStyle(
                                            color: AppColor.main,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            cartController.updateCount(
                                              cardId: item.id,
                                              isAdd: true,
                                              count: item.count,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColor.main,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "$newPrice ${AppStrings.currecy}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: AppColor.main,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
