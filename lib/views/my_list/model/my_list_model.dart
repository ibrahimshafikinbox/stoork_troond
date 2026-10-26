import 'package:troond/views/product/model/product_preview.dart';

class MyListModel {
    final int id;
    final String name;
    final List<Item> items;

    MyListModel({
        required this.id,
        required this.name,
        required this.items,
    });

    factory MyListModel.fromJson(Map<String, dynamic> json) => MyListModel(
        id: json["id"],
        name: json["name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );
}

class Item {
    final int id;
    final ProductPreview product;
    final DateTime date;

    Item({
        required this.id,
        required this.product,
        required this.date,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        product: ProductPreview.fromJson(json["product"]),
        date: DateTime.parse(json["date"]),
    );
}
