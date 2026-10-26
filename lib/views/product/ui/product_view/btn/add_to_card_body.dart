// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../../../config/app_local/app_local.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../data/shared_pref/shared_pref.dart';
import '../../../../../widget/loading/loading_widget.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../../../model/product_preview.dart';
import '../widget/layout_widget.dart';

class AddToCartBody extends StatefulWidget {
  const AddToCartBody({super.key, required this.productPreview});
  final ProductPreview productPreview;

  @override
  State<AddToCartBody> createState() => _AddToCartBodyState();
}

class _AddToCartBodyState extends State<AddToCartBody> {
  int count = 1;
  updateProdutCount(bool isAdd) {
    if (isAdd == true) {
      setState(() {
        count++;
      });
    } else {
      if (count == 1) {
        setState(() {
          count = 1;
        });
      } else {
        setState(() {
          count--;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String mainImage = "";
    for (var element in widget.productPreview.images) {
      if (element.isMain == 1) {
        mainImage = element.path;
      }
    }

    CartController cartController = Provider.of<CartController>(context);
    var local = MyLocalizations.getLocal(context);
    return Material(
      color: AppColor.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(mainImage),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.productPreview.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColor.c121212,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            widget.productPreview.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColor.c414141,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                child: RateCard(
                                                  product: widget.productPreview,
                                                ),
                                              ),
                                              Text(
                                                "(${widget.productPreview.ratingCount} ${local.review})",
                                                style: const TextStyle(
                                                  color: AppColor.main,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${local.price} : ",
                                                style: const TextStyle(
                                                  color: AppColor.c414141,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "${widget.productPreview.price} ${AppStrings.currecy}",
                                                textAlign: TextAlign.right,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.main,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: AppColor.c121212,
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
                  LayoutWidget(productPreview: widget.productPreview),
                ],
              ),
            ),
          ),

          //*
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: AppColor.cF2F2F2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                updateProdutCount(false);
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: AppColor.cB6B6B6,
                              ),
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: const TextStyle(
                              color: AppColor.main,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                updateProdutCount(true);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: AppColor.c414141,
                                weight: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  cartController.isAdding == widget.productPreview.id
                      ? const LoadingWidget()
                      : Expanded(
                          flex: 2,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColor.main,
                              fixedSize: const Size(200, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              if (!SharedPref.isLogin()) {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.loginScreen,
                                );
                              } else {
                                await cartController.addToCart(
                                  id: widget.productPreview.id,
                                  context: context,
                                  count: count,
                                );
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  backgroundColor: const Color(0x000000ff),
                                  context: context,
                                  builder: (context) {
                                    return Material(
                                      color: AppColor.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    local.cart,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: AppColor.c282828,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                      Icons.clear,
                                                      color: AppColor.c121212,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 110,
                                                            width: 110,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image:
                                                                  DecorationImage(
                                                                image: CachedNetworkImageProvider(
                                                                    mainImage),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                widget
                                                                    .productPreview
                                                                    .name,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .c121212,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                widget
                                                                    .productPreview
                                                                    .description,
                                                                maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .c414141,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        local
                                                                            .addToCart,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              AppColor.c717171,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      const Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: AppColor
                                                                            .main,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "${local.items}($count)",
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          local.cartTotal,
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .c000000,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 24,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${widget.productPreview.price * count} ${AppStrings.currecy}",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                AppColor.main,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SafeArea(
                                            bottom: true,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                        color: AppColor.main,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          local
                                                              .continueShopping,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                AppColor.main,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          AppColor.main,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        AppRoutes.cartScreen,
                                                        arguments: true,
                                                      );
                                                    },
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          local.checkOut,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                AppColor.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: cartController.isAdding ==
                                    widget.productPreview.id
                                ? const LoadingWidget()
                                : Text(
                                    local.addToCart,
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
