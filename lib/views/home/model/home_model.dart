import 'package:troond/views/ads/models/ads_model.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/product/model/product_preview.dart';

class HomeModel {
  final List<ProductPreview> popluarProducts;
  final List<ProductPreview> mostSold;
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final List<CategoryModel> randomCategory;
  final Advertise slider;
  final Advertise advertise;

  HomeModel({
    required this.popluarProducts,
    required this.categories,
    required this.brands,
    required this.randomCategory,
    required this.mostSold,
    required this.advertise,
    required this.slider,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        popluarProducts: json["popluar_products"] == null
            ? []
            : List<ProductPreview>.from(
                json["popluar_products"].map((x) => ProductPreview.fromJson(x))),
        mostSold: json["most_sold"] == null
            ? []
            : List<ProductPreview>.from(
                json["most_sold"].map((x) => ProductPreview.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<CategoryModel>.from(
                json["categories"].map((x) => CategoryModel.fromJson(x))),
        brands: json["brands"] == null
            ? []
            : List<BrandModel>.from(
                json["brands"].map((x) => BrandModel.fromJson(x))),
        randomCategory: json["random_category"] == null
            ? []
            : List<CategoryModel>.from(
                json["random_category"].map((x) => CategoryModel.fromJson(x))),
        slider: json["slider"] == null
            ? Advertise(items: [])
            : Advertise.fromJson(json["slider"]),
        advertise: json["advertise"] == null
            ? Advertise(items: [])
            : Advertise.fromJson(json["advertise"]),
      );
}

class Advertise {
  final List<AdsModel> items;

  Advertise({
    required this.items,
  });

  factory Advertise.fromJson(Map<String, dynamic> json) => Advertise(
        items: json["items"] == null
            ? []
            : List<AdsModel>.from(json["items"].map((x) => AdsModel.fromJson(x))),
      );
}
