import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/product/model/product_preview.dart';

class BranPreview {
  final BrandModel brand;
  final List<ProductPreview> mostSold;
  final List<ProductPreview> products;
  final List<CategoryModel> categries;

  BranPreview({
    required this.brand,
    required this.mostSold,
    required this.products,
    required this.categries,
  });

  factory BranPreview.fromJson(Map<String, dynamic> json) {
    BrandModel brand;
    if (json.containsKey("brand") && json["brand"] != null && json["brand"] is Map<String, dynamic>) {
      brand = BrandModel.fromJson(json["brand"]);
    } else {
      brand = BrandModel.fromJson(json);
    }

    List<ProductPreview> mostSold = [];
    if (json["most_sold"] != null && json["most_sold"] is List) {
      mostSold = List<ProductPreview>.from(
          json["most_sold"].map((x) => ProductPreview.fromJson(x)));
    }

    List<ProductPreview> products = [];
    if (json["products"] != null && json["products"] is List) {
      products = List<ProductPreview>.from(
          json["products"].map((x) => ProductPreview.fromJson(x)));
    }

    List<CategoryModel> categries = [];
    if (json["categries"] != null && json["categries"] is List) {
      categries = List<CategoryModel>.from(
          json["categries"].map((x) => CategoryModel.fromJson(x)));
    }

    return BranPreview(
      brand: brand,
      mostSold: mostSold,
      products: products,
      categries: categries,
    );
  }
}
