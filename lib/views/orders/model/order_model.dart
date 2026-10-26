import 'dart:convert';
import 'package:troond/views/address/model/address_model.dart';
import 'package:troond/views/product/model/product_preview.dart';

class OrderModel {
  final Order order;
  final List<OrderModelItem> items;

  OrderModel({
    required this.order,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        order: Order.fromJson(json["order"]),
        items: List<OrderModelItem>.from(
          json["items"].map((x) => OrderModelItem.fromJson(x)),
        ),
      );
}

class OrderModelItem {
  final int id;
  final ProductPreview product;
  final int count;
  final int price;

  OrderModelItem({
    required this.id,
    required this.product,
    required this.count,
    required this.price,
  });

  factory OrderModelItem.fromJson(Map<String, dynamic> json) => OrderModelItem(
        id: json["id"],
        product: ProductPreview.fromJson(jsonDecode(json["product_details"]) ),
        count: json["count"] ?? 1,
        price: json["price"] ?? 0,
      );
}

class Order {
  final int id;
  final String total;
  final String status;
  final List<OrderItem> items;
  final AddressModel address;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.total,
    required this.status,
    required this.items,
    required this.address,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        total: json["total"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        address: AddressModel.fromJson(jsonDecode(json["address"] ?? {})),
        items: List<OrderItem>.from(
          json["items"].map((x) => OrderItem.fromJson(x)),
        ),
      );
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int count;
  final int price;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.count,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        count: json["count"],
        price: json["price"],
      );
}
