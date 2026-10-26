import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/views/cart/model/product_cart.dart';
import 'package:troond/views/cart/services/cart_services.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/toast/build_toast.dart';
import '../../../config/app_local/app_local.dart';
import 'cart_empty.dart';
import 'cart_products.dart';
import 'from_your_fav.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.hasLeading});
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Provider.of<CartController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.cart),
        leading: hasLeading ? const BackButton() : const SizedBox(),
      ),
      body: FutureBuilder<List<ProductCart>>(
        future: CartServices().getCart(),
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(key: SharedConsts.cart);
          if (cache == null) {
            return CartEmpty(hasLeading: hasLeading);
          } else {
            var data = jsonDecode(cache);
            List<ProductCart> productsCart = [];
            for (var element in data["data"]) {
              productsCart.add(ProductCart.fromJson(element));
            }
            productsCart.removeWhere((element) => element.product == null);

            var result = snapshot.hasData ? snapshot.data! : productsCart;
            int total = 0;
            for (var element in result) {
              total += element.product!.price * element.count;
            }
            return result.isEmpty
                ? CartEmpty(hasLeading: hasLeading)
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CartProductsWidget(
                                data: result,
                                cartController: cartController,
                              ),
                              const Divider(color: AppColor.cDADCE3),
                              const FromYourFavorite(),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Container(
                          height: 60,
                          color: AppColor.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "$total ${AppStrings.currecy}",
                                        style: const TextStyle(
                                          color: AppColor.main,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: BuildTextBtn(
                                  color: AppColor.main,
                                  onTap: () {
                                    var yourCart = result
                                        .where((element) =>
                                            element.addToCart == true)
                                        .toList();
                                    if (yourCart.isEmpty) {
                                      BuildToast.success(
                                        title: local.chooseAtLeastOneProduct,
                                      );
                                    } else {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.checkoutScreen,
                                        arguments: yourCart,
                                      );
                                    }
                                  },
                                  text: local.checkOut,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}
