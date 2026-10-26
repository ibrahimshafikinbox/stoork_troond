import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/views/orders/helper/order_helper.dart';
import 'package:troond/views/orders/services/orders_services.dart';
import 'package:troond/views/orders/ui/orders_screen/order_list_screen.dart';
import 'package:troond/widget/loading/loading_widget.dart';

import '../../../../config/app_local/app_local.dart';
import '../../model/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CartController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(title: Text(local.orders)),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            //* tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                indicatorColor: AppColor.main,
                physics: const NeverScrollableScrollPhysics(),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                tabs: [
                  Tab(text: local.all),
                  Tab(text: local.active),
                  Tab(text: local.completed),
                  Tab(text: local.cancel),
                ],
              ),
            ),

            FutureBuilder<List<OrderModel>>(
              future: OrdersServices().getOrders(),
              builder: (context, snapshot) {
                var cache = SharedPref.getKey(key: SharedConsts.orders);
                if (cache == null) {
                  return const LoadingWidget();
                } else {
                  var result = jsonDecode(cache);
                  List<OrderModel> ordersJson = [];
                  for (var element in result["data"]) {
                    ordersJson.add(OrderModel.fromJson(element));
                  }
                  var data = snapshot.hasData ? snapshot.data! : ordersJson;
                  List<OrderModel>? orders = data.reversed.toList();
                  List<OrderModel>? canceledOrders = data
                      .where((element) =>
                          element.order.status == OrderHelper.canceled)
                      .toList();
                  List<OrderModel>? deliveredOrders = data
                      .where((element) =>
                          element.order.status == OrderHelper.delivered)
                      .toList();
                  List<OrderModel>? activedOrders = data
                      .where((element) =>
                          element.order.status == OrderHelper.process)
                      .toList();
                  return Expanded(
                    child: TabBarView(
                      children: [
                        OrdersListScreen(orders: orders),
                        OrdersListScreen(orders: activedOrders),
                        OrdersListScreen(orders: deliveredOrders),
                        OrdersListScreen(orders: canceledOrders),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
