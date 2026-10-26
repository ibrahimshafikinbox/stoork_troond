import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';

class ProductPreview {
  final int id;
  String name;
  final String description;
  final bool status;
  final int stockCount;
  final List<ProductPreviewImage> images;
  final List<Option> options;
  final List<Review> review;
  final double? rating;
  final int ratingCount;
  final List<RatingInfo> ratingInfo;
  final List<Overveiw> overveiw;
  final BrandModel? brand;
  final CategoryModel? category;
  final List<RelatedProduct> relatedProducts;
  final String unit;
  final String material;
  final int price;
  final List<Detail> details;
  final String discount;
  final String basePrice;

  ProductPreview({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.stockCount,
    required this.images,
    required this.options,
    required this.review,
    required this.rating,
    required this.ratingCount,
    required this.ratingInfo,
    required this.overveiw,
    required this.brand,
    required this.category,
    required this.relatedProducts,
    required this.unit,
    required this.material,
    required this.price,
    required this.details,
    required this.discount,
    required this.basePrice,
  });

  factory ProductPreview.fromJson(Map<String, dynamic> json) {
    int priceVal = 0;
    List candidatePriceKeys = [
      json["price"],
      json["lowest_price"],
      json["discount_price"],
      json["original_price"],
      json["base_price"],
      json["sale_price"],
      json["unit_price"],
      json["final_price"],
      json["min_price"],
      json["max_price"],
      json["offer_price"],
      json["selling_price"],
      json["amount"],
      json["product"],
      json["pivot"],
      json["current_variant"],
      json["variants"],
      json["options"],
      json["prices"],
      json["colors"],
      json["product_variants"],
      json["details"],
    ];
    for (var k in candidatePriceKeys) {
      int p = _parsePriceValue(k);
      if (p > 0) {
        priceVal = p;
        break;
      }
    }

    List rawImages = [];
    if (json["images"] is List && (json["images"] as List).isNotEmpty) {
      rawImages = json["images"];
    } else if (json["current_variant"]?["images"] is List &&
        (json["current_variant"]["images"] as List).isNotEmpty) {
      rawImages = json["current_variant"]["images"];
    } else if (json["colors"] is List &&
        (json["colors"] as List).isNotEmpty &&
        json["colors"][0]["images"] is List &&
        (json["colors"][0]["images"] as List).isNotEmpty) {
      rawImages = json["colors"][0]["images"];
    } else if (json["image"] != null) {
      rawImages = [json["image"]];
    } else if (json["full_image"] != null) {
      rawImages = [json["full_image"]];
    } else if (json["image_path"] != null) {
      rawImages = [json["image_path"]];
    } else if (json["thumbnail_image"] != null) {
      rawImages = [json["thumbnail_image"]];
    } else if (json["thumbnail_path"] != null) {
      rawImages = [json["thumbnail_path"]];
    } else if (json["main_image"] != null) {
      rawImages = [json["main_image"]];
    } else if (json["photo"] != null) {
      rawImages = [json["photo"]];
    } else if (json["img"] != null) {
      rawImages = [json["img"]];
    } else if (json["product"] != null && json["product"] is Map) {
      var prod = json["product"];
      if (prod["images"] is List && (prod["images"] as List).isNotEmpty) {
        rawImages = prod["images"];
      } else if (prod["image"] != null) {
        rawImages = [prod["image"]];
      } else if (prod["full_image"] != null) {
        rawImages = [prod["full_image"]];
      } else if (prod["image_path"] != null) {
        rawImages = [prod["image_path"]];
      }
    }

    return ProductPreview(
      id: json["product_id"] ?? json["id"] ?? 0,
      name: _getLocalizedText(
        json: json,
        arKeys: ["name_ar", "title_ar", "nameAr"],
        enKeys: ["name_en", "title_en", "nameEn"],
        generalKeys: ["name", "title"],
      ),
      discount: json["discount"]?.toString() ?? "",
      description: _cleanHtml(
        _getLocalizedText(
          json: json,
          arKeys: ["description_ar", "desc_ar", "descriptionAr"],
          enKeys: ["description_en", "desc_en", "descriptionEn"],
          generalKeys: ["description", "desc"],
        ),
      ),
      status: _parseBoolValue(json["status"]),
      stockCount: json["stock_count"] == null
          ? 0
          : (json["stock_count"] is num
              ? (json["stock_count"] as num).toInt()
              : int.tryParse(json["stock_count"].toString()) ?? 0),
      images: List<ProductPreviewImage>.from(
          rawImages.map((x) => ProductPreviewImage.fromJson(x))),
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      review: json["review"] == null
          ? []
          : List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
      rating: () {
        dynamic r = json["rating"] ??
            json["avg_rating"] ??
            json["average_rating"] ??
            json["rating_avg"] ??
            json["reviews_avg_rating"];
        if (r == null) return 0.0;
        if (r is num) return r.toDouble();
        return double.tryParse(r.toString()) ?? 0.0;
      }(),
      ratingCount: () {
        dynamic rc = json["rating_count"] ??
            json["reviews_count"] ??
            json["total_reviews"] ??
            json["review_count"];
        if (rc == null) {
          if (json["review"] is List) return (json["review"] as List).length;
          return 0;
        }
        if (rc is num) return rc.toInt();
        return int.tryParse(rc.toString()) ?? 0;
      }(),
      ratingInfo: json["rating_info"] == null
          ? []
          : List<RatingInfo>.from(
              json["rating_info"].map((x) => RatingInfo.fromJson(x))),
      overveiw: json["overveiw"] == null
          ? []
          : List<Overveiw>.from(
              json["overveiw"].map((x) => Overveiw.fromJson(x))),
      brand: json["brand"] == null ? null : BrandModel.fromJson(json["brand"]),
      category: json["category"] == null
          ? null
          : CategoryModel.fromJson(json["category"]),
      relatedProducts: json["related_products"] == null
          ? []
          : List<RelatedProduct>.from(
              json["related_products"].map((x) => RelatedProduct.fromJson(x))),
      unit: json["unit"] ?? "",
      basePrice: json["base_price"]?.toString() ?? "",
      material: json["material"] ?? "",
      price: priceVal,
      details: json["details"] == null
          ? []
          : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );
  }
}

class Detail {
  final int id;
  final int productId;
  final String color;
  final String size;
  final int count;

  Detail({
    required this.id,
    required this.productId,
    required this.color,
    required this.size,
    required this.count,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] ?? 0,
        productId: json["product_id"] ?? 0,
        color: json["color"] ?? "",
        size: json["size"] ?? "",
        count: json["count"] == null
            ? 0
            : (json["count"] is num
                ? (json["count"] as num).toInt()
                : int.tryParse(json["count"].toString()) ?? 0),
      );
}

class ProductPreviewImage {
  final int id;
  final String path;
  final int order;
  final int isMain;

  ProductPreviewImage({
    required this.id,
    required this.path,
    required this.order,
    required this.isMain,
  });

  factory ProductPreviewImage.fromJson(dynamic json) {
    if (json == null) {
      return ProductPreviewImage(id: 0, path: "", order: 0, isMain: 0);
    }

    if (json is String) {
      String pathStr = json.trim();
      if (pathStr.isNotEmpty &&
          !pathStr.startsWith("http://") &&
          !pathStr.startsWith("https://")) {
        pathStr = pathStr.startsWith("/")
            ? "https://api.troond.com$pathStr"
            : "https://api.troond.com/$pathStr";
      }
      return ProductPreviewImage(
        id: 0,
        path: pathStr,
        order: 0,
        isMain: 1,
      );
    }

    if (json is Map) {
      String p = json["path"]?.toString() ??
          json["full_image"]?.toString() ??
          json["image_path"]?.toString() ??
          json["thumbnail_image"]?.toString() ??
          json["thumbnail_path"]?.toString() ??
          json["image"]?.toString() ??
          json["photo"]?.toString() ??
          json["url"]?.toString() ??
          "";
      p = p.trim();
      if (p.isNotEmpty &&
          !p.startsWith("http://") &&
          !p.startsWith("https://")) {
        p = p.startsWith("/")
            ? "https://api.troond.com$p"
            : "https://api.troond.com/$p";
      }
      return ProductPreviewImage(
        id: json["id"] == null
            ? 0
            : (json["id"] is num
                ? (json["id"] as num).toInt()
                : int.tryParse(json["id"].toString()) ?? 0),
        path: p,
        order: json["order"] == null
            ? 0
            : (json["order"] is num
                ? (json["order"] as num).toInt()
                : int.tryParse(json["order"].toString()) ?? 0),
        isMain: json["is_main"] == null
            ? 1
            : (json["is_main"] is num
                ? (json["is_main"] as num).toInt()
                : (json["is_main"] == true ? 1 : 0)),
      );
    }

    return ProductPreviewImage(id: 0, path: "", order: 0, isMain: 0);
  }
}

class Option {
  final int id;
  final String name;
  final String value;
  final int order;

  Option({
    required this.id,
    required this.name,
    required this.value,
    required this.order,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        value: json["value"] ?? "",
        order: json["order"] == null
            ? 0
            : (json["order"] is num
                ? (json["order"] as num).toInt()
                : int.tryParse(json["order"].toString()) ?? 0),
      );
}

class Overveiw {
  final int id;
  final String header;
  final String description;
  final List<dynamic> items;

  Overveiw({
    required this.id,
    required this.header,
    required this.description,
    required this.items,
  });

  factory Overveiw.fromJson(Map<String, dynamic> json) => Overveiw(
        id: json["id"] ?? 0,
        header: _cleanHtml(json["header"] ?? ""),
        description: _cleanHtml(json["description"] ?? ""),
        items: json["items"] == null
            ? []
            : List<dynamic>.from(json["items"].map((x) => x)),
      );
}

class RatingInfo {
  final int rating;
  final int count;

  RatingInfo({
    required this.rating,
    required this.count,
  });

  factory RatingInfo.fromJson(Map<String, dynamic> json) => RatingInfo(
        rating: json["rating"] == null
            ? 0
            : (json["rating"] is num
                ? (json["rating"] as num).toInt()
                : int.tryParse(json["rating"].toString()) ?? 0),
        count: json["count"] == null
            ? 0
            : (json["count"] is num
                ? (json["count"] as num).toInt()
                : int.tryParse(json["count"].toString()) ?? 0),
      );
}

class RelatedProduct {
  final int id;
  final String name;
  final String description;
  final bool status;
  final int stockCount;
  final ProductPreviewImage? image;
  final int? rating;
  final String price;

  RelatedProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.stockCount,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    ProductPreviewImage? parsedImg;
    if (json["image"] != null) {
      parsedImg = ProductPreviewImage.fromJson(json["image"]);
    } else if (json["images"] != null && (json["images"] as List).isNotEmpty) {
      parsedImg = ProductPreviewImage.fromJson(json["images"][0]);
    } else if (json["colors"] != null &&
        (json["colors"] as List).isNotEmpty &&
        json["colors"][0]["images"] != null &&
        (json["colors"][0]["images"] as List).isNotEmpty) {
      parsedImg = ProductPreviewImage.fromJson(json["colors"][0]["images"][0]);
    } else if (json["full_image"] != null ||
        json["image_path"] != null ||
        json["thumbnail_image"] != null) {
      parsedImg = ProductPreviewImage(
        id: json["id"] ?? 0,
        path: json["full_image"] ??
            json["image_path"] ??
            json["thumbnail_image"] ??
            "",
        order: 0,
        isMain: 1,
      );
    }

    int relPriceInt = 0;
    List candidatePriceKeys = [
      json["price"],
      json["lowest_price"],
      json["discount_price"],
      json["original_price"],
      json["base_price"],
      json["sale_price"],
    ];
    for (var k in candidatePriceKeys) {
      int p = _parsePriceValue(k);
      if (p > 0) {
        relPriceInt = p;
        break;
      }
    }

    return RelatedProduct(
      id: json["product_id"] ?? json["id"] ?? 0,
      name: _getLocalizedText(
        json: json,
        arKeys: ["name_ar", "title_ar", "nameAr"],
        enKeys: ["name_en", "title_en", "nameEn"],
        generalKeys: ["name", "title"],
      ),
      description: _cleanHtml(
        _getLocalizedText(
          json: json,
          arKeys: ["description_ar", "desc_ar", "descriptionAr"],
          enKeys: ["description_en", "desc_en", "descriptionEn"],
          generalKeys: ["description", "desc"],
        ),
      ),
      status: _parseBoolValue(json["status"]),
      stockCount: json["stock_count"] == null
          ? 0
          : (json["stock_count"] is num
              ? (json["stock_count"] as num).toInt()
              : int.tryParse(json["stock_count"].toString()) ?? 0),
      image: parsedImg,
      rating: json["rating"] == null
          ? 0
          : (json["rating"] is num
              ? (json["rating"] as num).toInt()
              : int.tryParse(json["rating"].toString()) ?? 0),
      price: relPriceInt > 0
          ? relPriceInt.toString()
          : (json["price"]?.toString() ?? "0"),
    );
  }
}

class ProductImage {
  final int id;
  final String path;
  final int order;
  final int isMain;
  final int productId;

  ProductImage({
    required this.id,
    required this.path,
    required this.order,
    required this.isMain,
    required this.productId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"] ?? 0,
        path: json["path"] ?? "",
        order: json["order"] == null
            ? 0
            : (json["order"] is num
                ? (json["order"] as num).toInt()
                : int.tryParse(json["order"].toString()) ?? 0),
        isMain: json["is_main"] == null
            ? 0
            : (json["is_main"] is num
                ? (json["is_main"] as num).toInt()
                : (json["is_main"] == true ? 1 : 0)),
        productId: json["product_id"] ?? 0,
      );
}

class Review {
  final int userId;
  final User user;
  final int rating;
  final String comment;

  Review({
    required this.userId,
    required this.user,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        userId: json["user_id"] ?? 0,
        user: json["user"] == null
            ? User(name: "", email: "", image: "")
            : User.fromJson(json["user"]),
        rating: json["rating"] == null
            ? 0
            : (json["rating"] is num
                ? (json["rating"] as num).toInt()
                : int.tryParse(json["rating"].toString()) ?? 0),
        comment: json["comment"] ?? "",
      );
}

class User {
  final String name;
  final String email;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        image: json["image"] ?? "",
      );
}

int _parsePriceValue(dynamic val) {
  if (val == null) return 0;

  if (val is num) {
    return val.round();
  }

  if (val is String) {
    String cleanStr = val.trim().replaceAll(',', '');
    if (cleanStr.isEmpty) return 0;
    double? d = double.tryParse(cleanStr);
    if (d != null) return d.round();
    return int.tryParse(cleanStr.split('.').first) ?? 0;
  }

  if (val is Map) {
    dynamic p = val["discount_price"] ??
        val["price"] ??
        val["lowest_price"] ??
        val["original_price"] ??
        val["base_price"] ??
        val["sale_price"] ??
        val["final_price"] ??
        val["unit_price"] ??
        val["min_price"] ??
        val["max_price"] ??
        val["offer_price"] ??
        val["selling_price"] ??
        val["amount"] ??
        val["pivot_price"] ??
        val["cost"] ??
        val["product"];
    return _parsePriceValue(p);
  }

  if (val is List && val.isNotEmpty) {
    for (var item in val) {
      int parsed = _parsePriceValue(item);
      if (parsed > 0) return parsed;
    }
  }

  return 0;
}

String _cleanHtml(dynamic raw) {
  if (raw == null) return "";
  String htmlString = raw.toString();
  if (htmlString.trim().isEmpty) return "";

  String text = htmlString;
  text = text
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n\n')
      .replaceAll(RegExp(r'</li>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<li>', caseSensitive: false), '• ')
      .replaceAll(RegExp(r'</tr>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</td>', caseSensitive: false), '  ');

  text = text.replaceAll(RegExp(r'<[^>]*>'), '');

  text = text
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&#39;', "'");

  return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
}

String _getLocalizedText({
  required Map<String, dynamic> json,
  required List<String> arKeys,
  required List<String> enKeys,
  required List<String> generalKeys,
}) {
  String currentLang = SharedPref.getLanguage();

  String arVal = "";
  for (var k in arKeys) {
    if (json[k] != null && json[k].toString().trim().isNotEmpty) {
      arVal = json[k].toString().trim();
      break;
    }
  }

  String enVal = "";
  for (var k in enKeys) {
    if (json[k] != null && json[k].toString().trim().isNotEmpty) {
      enVal = json[k].toString().trim();
      break;
    }
  }

  String genVal = "";
  for (var k in generalKeys) {
    if (json[k] != null && json[k].toString().trim().isNotEmpty) {
      genVal = json[k].toString().trim();
      break;
    }
  }

  if (currentLang == 'en') {
    if (enVal.isNotEmpty) return enVal;
    if (genVal.isNotEmpty) return genVal;
    return arVal;
  } else {
    if (arVal.isNotEmpty) return arVal;
    if (genVal.isNotEmpty) return genVal;
    return enVal;
  }
}

bool _parseBoolValue(dynamic val) {
  if (val == null) return false;
  if (val is bool) return val;
  if (val is num) return val == 1;
  if (val is String) {
    String s = val.trim().toLowerCase();
    return s == "1" || s == "true" || s == "active" || s == "yes";
  }
  return false;
}
