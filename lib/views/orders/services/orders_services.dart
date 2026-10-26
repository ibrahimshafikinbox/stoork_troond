import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

import '../model/order_model.dart';

class OrdersServices {
  Future<List<OrderModel>> getOrders() async {
    var url = AppNetWork.getBaseUrl("orders/user");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      await SharedPref.setKey(value: response.body, key: SharedConsts.orders);
      List<OrderModel> orders = [];
      for (var element in result["data"]) {
        orders.add(OrderModel.fromJson(element));
      }
      return orders;
    } else {
      return [];
    }
  }

  Future<OrderModel?> getSingleOrders(int id) async {
    var url = AppNetWork.getBaseUrl("orders/user/$id");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      OrderModel orders = OrderModel.fromJson(result["data"]);
      return orders;
    } else {
      return null;
    }
  }

  Future checkout({required List items}) async {
    var url = AppNetWork.getBaseUrl("orders");
    var body = jsonEncode({"items": items});
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  Future changeStatus({required int orderId, required String status}) async {
    var url = AppNetWork.getBaseUrl("orders/$orderId");
    var body = jsonEncode({"status": status});
    http.Response response = await http.put(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  Future review({
    required int productId,
    required int rating,
    required String comment,
  }) async {
    var url = AppNetWork.getBaseUrl("rating");
    var body = jsonEncode({
      "product_id": productId,
      "rating": rating,
      "comment": comment,
    });
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }
}
