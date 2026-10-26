import 'package:troond/views/brands/model/brand_model.dart';

class ChatSellerInfo {
  final int id;
  final String name;
  final String? storeName;
  final String? logo;
  final double? rating;
  final int ratingCount;
  final bool isVerified;
  final bool isOnline;

  ChatSellerInfo({
    required this.id,
    required this.name,
    this.storeName,
    this.logo,
    this.rating,
    this.ratingCount = 0,
    this.isVerified = true,
    this.isOnline = true,
  });

  factory ChatSellerInfo.fromBrand(
    BrandModel? brand, {
    double? rating,
    int? ratingCount,
  }) {
    if (brand == null) {
      return ChatSellerInfo(
        id: 0,
        name: "المتجر",
        storeName: "المتجر",
        logo: "",
        rating: rating ?? 5.0,
        ratingCount: ratingCount ?? 0,
        isVerified: true,
        isOnline: true,
      );
    }

    return ChatSellerInfo(
      id: brand.id,
      name: brand.name.isNotEmpty ? brand.name : "المتجر",
      storeName: brand.name,
      logo: brand.logo.isNotEmpty ? brand.logo : brand.image,
      rating: rating,
      ratingCount: ratingCount ?? 0,
      isVerified: true,
      isOnline: true,
    );
  }

  factory ChatSellerInfo.fromJson(Map<String, dynamic> json) {
    return ChatSellerInfo(
      id: json['id'] ?? json['seller_id'] ?? 0,
      name: json['name'] ?? json['seller_name'] ?? json['brand_name'] ?? '',
      storeName: json['store_name'] ?? json['shop_name'],
      logo: json['logo'] ?? json['avatar'] ?? json['image'],
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      ratingCount: json['rating_count'] ?? json['reviews_count'] ?? 0,
      isVerified: json['is_verified'] ?? true,
      isOnline: json['is_online'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'store_name': storeName,
      'logo': logo,
      'rating': rating,
      'rating_count': ratingCount,
      'is_verified': isVerified,
      'is_online': isOnline,
    };
  }
}
