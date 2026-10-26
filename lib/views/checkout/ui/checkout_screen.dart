import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/address/model/address_model.dart';
import 'package:troond/views/address/services/address_services.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/text/build_header.dart';
import 'package:troond/widget/toast/build_toast.dart';
import '../../../config/app_local/app_local.dart';
import '../../address/controller/address_controller.dart';
import '../../cart/model/product_cart.dart';
import '../widget/build_order_summery_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.yourCart});
  final List<ProductCart> yourCart;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool hasAddress = false;

  @override
  void initState() {
    super.initState();
    AddressServices().getAddress().then((value) {
      setState(() {
        hasAddress = value.isEmpty ? false : true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    Provider.of<AddressController>(context);
    int total = 0;
    for (var element in widget.yourCart) {
      total += element.product!.price;
    }
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(local.checkOut),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.yourCart.length} ${local.items}",
                      style: const TextStyle(
                        color: AppColor.c717171,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "$total ${AppStrings.currecy}",
                      style: const TextStyle(
                        color: AppColor.main,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              cartController.isCheckout
                  ? const LoadingWidget()
                  : BuildTextBtn(
                      color: AppColor.main,
                      onTap: () async {
                        if (hasAddress == false) {
                          BuildToast.success(title: local.chooseAnAddressFirst);
                        } else {
                          List items = [];
                          for (var element in widget.yourCart) {
                            items.add({
                              "id": element.id,
                              "count": element.count,
                            });
                          }
                          cartController.checkout(
                            items: items,
                            context: context,
                          );
                        }
                      },
                      text: "Confirm",
                    ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                //* Shipping Address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildHeader(text: local.shippingAddress),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColor.cDADCE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<List<AddressModel>>(
                          future: AddressServices().getAddress(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const LoadingWidget();
                            } else {
                              var result = snapshot.data!;
                              hasAddress = result.isEmpty ? false : true;
                              AddressModel? addressModel =
                                  result.isEmpty ? null : snapshot.data![0];
                              if (result.isNotEmpty) {
                                for (var element in result) {
                                  if (element.isDefault == true) {
                                    addressModel = element;
                                  }
                                }
                              }
                              return Column(
                                children: [
                                  ListTile(
                                    minLeadingWidth: 0,
                                    title: addressModel == null
                                        ? const SizedBox()
                                        : Text(
                                            addressModel.mainAdress,
                                            style: const TextStyle(
                                              color: AppColor.c64646D,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                    leading: const Icon(Icons.place_outlined),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          AppRoutes.changeAddressScreen,
                                        );
                                      },
                                      child: Text(
                                        result.isEmpty
                                            ? local.addAddress
                                            : local.changeAddress,
                                        style: const TextStyle(
                                          color: AppColor.c29296E,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //* Your Order
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildHeader(text: local.yourOrder),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: widget.yourCart.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var cartProduct = widget.yourCart[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColor.cDADCE3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${local.shipment} ${index + 1} of ${widget.yourCart.length}",
                                      style: const TextStyle(
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "(${cartProduct.count} ${local.items})",
                                      style: const TextStyle(
                                        color: AppColor.c717171,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image(
                                        height: 100,
                                        width: 50,
                                        image: CachedNetworkImageProvider(
                                          cartProduct.product!.images[0].path,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    cartProduct.product!.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: AppColor.c121212,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${cartProduct.product!.price} ${AppStrings.currecy}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: AppColor.main,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              cartProduct.product!.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: AppColor.c121212,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            cartProduct.detail == null
                                                ? const SizedBox()
                                                : Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${local.size} : ${cartProduct.detail!.size}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            color: AppColor
                                                                .c121212,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "${local.color} : ${cartProduct.detail!.color}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            color: AppColor
                                                                .c121212,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      local.deliveryBy,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColor.c000000,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "sat ,sep 16",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColor.c38AE04,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                //* Your Order
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildHeader(text: local.yourOrder),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColor.cDADCE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: AppColor.main),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.radio_button_checked_rounded,
                                        color: AppColor.main,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: AppColor.c38AE04),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            local.cash,
                                            style: const TextStyle(
                                              color: AppColor.c38AE04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      local.cashOnDelivery,
                                      style: const TextStyle(
                                        color: AppColor.c000000,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          local.extraCharge,
                                          style: const TextStyle(
                                            color: AppColor.c717171,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Text(
                                          " 0 ${AppStrings.currecy}",
                                          style: TextStyle(
                                            color: AppColor.c717171,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Card(
                                  color: AppColor.c38AE04,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      local.cash,
                                      style: const TextStyle(
                                          color: AppColor.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //* Order summary
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    BuildHeader(text: local.orderSummary),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColor.cDADCE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              local.orderSummary,
                              style: const TextStyle(
                                color: AppColor.c121212,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            BuildOrderSummeryWidget(
                              text:
                                  "${local.subtotal} (${widget.yourCart.length} ${local.items})",
                              value: "${AppStrings.currecy} $total",
                            ),
                            const SizedBox(height: 10),
                            BuildOrderSummeryWidget(
                              text: local.shippingDetails,
                              value: "${AppStrings.currecy} 0.00",
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.total,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${AppStrings.currecy} $total",
                                  style: const TextStyle(
                                    color: AppColor.main,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
