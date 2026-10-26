import 'package:troond/views/product/model/product_preview.dart';

class AdsModel {
  final int id;
  final int isHome;
  final int? categoryId;
  final int? brandId;
  final bool isSlider;
  final int? productId;
  final ProductPreview? product;
  final dynamic fullImage;
  final dynamic mobileImage;

  AdsModel({
    required this.id,
    required this.isHome,
    required this.categoryId,
    required this.brandId,
    required this.isSlider,
    required this.productId,
    required this.product,
    required this.fullImage,
    required this.mobileImage,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        id: json["id"],
        isHome: json["is_home"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        isSlider: json["is_slider"],
        productId: json["product_id"],
        fullImage: json["full_image"] ?? "",
        mobileImage: json["mobile_image"] ?? "",
        product: json["product"] == null
            ? null
            : ProductPreview.fromJson(json["product"]),
      );
}
