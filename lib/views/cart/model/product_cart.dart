import 'package:troond/views/product/model/product_preview.dart';

class ProductCart {
  final int id;
  final int user;
  final ProductPreview? product;
  int count;
  bool addToCart;
  final Detail? detail;

  ProductCart({
    required this.id,
    required this.user,
    required this.product,
    required this.count,
    required this.detail,
    required this.addToCart,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? rawProduct =
        json["product"] ?? json["variant"] ?? json["product_preview"];
    ProductPreview? parsedProduct;
    if (rawProduct != null) {
      Map<String, dynamic> pMap = Map<String, dynamic>.from(rawProduct);
      if (json["full_price"] != null && json["full_price"]["discount_price"] != null) {
        pMap["price"] = json["full_price"]["discount_price"];
      } else if (json["price"] != null) {
        pMap["price"] = json["price"];
      }
      try {
        parsedProduct = ProductPreview.fromJson(pMap);
      } catch (e) {
        print("❌ Error parsing product in ProductCart.fromJson: $e");
      }
    }

    Detail? parsedDetail;
    var rawDetail = json["details"] ?? json["detail"] ?? json["full_price"];
    if (rawDetail != null && rawDetail is Map<String, dynamic>) {
      try {
        parsedDetail = Detail.fromJson(rawDetail);
      } catch (_) {}
    }

    bool isSelected = true;
    if (json["addToCart"] != null) {
      isSelected = json["addToCart"] == true;
    } else if (json["is_selected"] != null) {
      isSelected = json["is_selected"] == true || json["is_selected"] == 1;
    } else if (json["selected"] != null) {
      isSelected = json["selected"] == true || json["selected"] == 1;
    }

    return ProductCart(
      id: json["id"] ?? 0,
      user: json["user"] == null
          ? (json["user_id"] ?? 0)
          : (json["user"] is num
              ? (json["user"] as num).toInt()
              : (json["user"] is Map
                  ? (json["user"]["id"] ?? 0)
                  : int.tryParse(json["user"].toString()) ?? 0)),
      count: json["count"] == null
          ? 1
          : (json["count"] is num
              ? (json["count"] as num).toInt()
              : int.tryParse(json["count"].toString()) ?? 1),
      addToCart: isSelected,
      product: parsedProduct,
      detail: parsedDetail,
    );
  }
}
