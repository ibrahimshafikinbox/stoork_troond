// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/cart/services/cart_services.dart';
import 'package:troond/views/orders/services/orders_services.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../../../config/app_local/app_local.dart';
import '../../product/model/product_preview.dart';

class CartController extends ChangeNotifier {
  CartServices cartServices = CartServices();
  int? isAdding;

  Future delete({required int id, required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    isAdding = id;
    notifyListeners();
    await cartServices.delete(cardId: id);
    isAdding = null;
    notifyListeners();
    BuildToast.success(title: local.deletedToCart);
  }

  chooseToCart(bool value, bool addToCart) {
    addToCart = value;
    notifyListeners();
  }

  Future updateCount({
    required int cardId,
    required int count,
    required bool isAdd,
  }) async {
    if (isAdd) {
      count++;
      notifyListeners();
    } else {
      if (count > 1) {
        count--;
        notifyListeners();
      } else {
        count == 1;
        notifyListeners();
      }
    }
    await cartServices.updateCount(count: count, cardId: cardId);
    notifyListeners();
  }

  //* colors and sizes
  List<Detail> newDetails = [];
  chooseSize({
    required List<Detail> details,
    required String size,
    required String color,
  }) {
    newDetails.clear();
    for (var element in details) {
      if (element.size == size || element.color == color) {
        newDetails.add(element);
        notifyListeners();
      }
    }
  }

  Future addToCart({
    required int id,
    required BuildContext context,
    required int count,
    int? productVariantId,
    int? sizeId,
  }) async {
    if (!SharedPref.isLogin()) {
      BuildToast.error(title: "يرجى تسجيل الدخول أولاً لإضافة المنتجات إلى السلة");
      Navigator.of(context).pushNamed(AppRoutes.loginScreen);
      return;
    }

    isAdding = id;
    notifyListeners();
    bool success = await cartServices.addToCart(
      id: id,
      detailId: newDetails.isEmpty ? null : newDetails[0].id,
      count: count,
      productVariantId: productVariantId,
      sizeId: sizeId,
    );
    isAdding = null;
    newDetails.clear();
    notifyListeners();

    if (success) {
      BuildToast.success(title: "تمت إضافة المنتج إلى السلة بنجاح");
      Navigator.of(context).pushNamed(AppRoutes.cartScreen);
    } else {
      BuildToast.error(title: "تعذر إضافة المنتج إلى السلة، يرجى المحاولة لاحقاً");
    }
  }

  OrdersServices ordersServices = OrdersServices();
  bool isCheckout = false;
  Future checkout({
    required List<dynamic> items,
    required BuildContext context,
  }) async {
    isCheckout = true;
    notifyListeners();
    await ordersServices.checkout(items: items);
    isCheckout = false;
    notifyListeners();
    Navigator.of(context).pushNamed(AppRoutes.checkoutDoneScreen);
  }

  Future changeOrderStatus({
    required int orderId,
    required String status,
  }) async {
    await ordersServices.changeStatus(orderId: orderId, status: status);
    notifyListeners();
  }
}
