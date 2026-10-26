import 'package:troond/views/product/model/product_preview.dart';

class ChatProductContext {
  final int id;
  final String name;
  final String image;
  final String price;
  final String? basePrice;
  final String? discount;

  ChatProductContext({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.basePrice,
    this.discount,
  });

  factory ChatProductContext.fromProduct(ProductPreview product) {
    String mainImage = '';
    if (product.images.isNotEmpty) {
      mainImage = product.images.first.path;
    }

    return ChatProductContext(
      id: product.id,
      name: product.name,
      image: mainImage,
      price: product.price.toString(),
      basePrice: product.basePrice.isNotEmpty &&
              product.basePrice != product.price.toString()
          ? product.basePrice
          : null,
      discount: product.discount.isNotEmpty && product.discount != '0'
          ? product.discount
          : null,
    );
  }

  factory ChatProductContext.fromJson(Map<String, dynamic> json) {
    return ChatProductContext(
      id: json['id'] ?? json['product_id'] ?? 0,
      name: json['name'] ?? json['title'] ?? '',
      image: json['image'] ?? json['photo'] ?? '',
      price: json['price']?.toString() ?? '0',
      basePrice: json['base_price']?.toString(),
      discount: json['discount']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'base_price': basePrice,
      'discount': discount,
    };
  }
}
