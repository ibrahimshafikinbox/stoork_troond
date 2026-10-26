import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';

class FilterModel {
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final int max;
  final int min;
  final List<dynamic> colors;
  final List<dynamic> sizes;

  FilterModel({
    required this.categories,
    required this.brands,
    required this.max,
    required this.min,
    required this.colors,
    required this.sizes,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        brands: List<BrandModel>.from(
            json["brands"].map((x) => BrandModel.fromJson(x))),
        colors: json["colors"] ?? [],
        sizes: json["sizes"]??[],
        max: int.parse(json["max"].toString().split(".").first),
        min:int.parse(json["min"].toString().split(".").first),
      );
}
