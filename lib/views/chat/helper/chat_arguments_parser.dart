import 'package:flutter/material.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/chat/model/chat_product_context.dart';
import 'package:troond/views/chat/model/chat_seller_info.dart';
import 'package:troond/views/product/model/product_preview.dart';

class ChatRouteData {
  final ChatSellerInfo seller;
  final ChatProductContext? product;

  ChatRouteData({
    required this.seller,
    this.product,
  });
}

class ChatArgumentsParser {
  static ChatRouteData parse(BuildContext context, {
    ChatSellerInfo? defaultSeller,
    ChatProductContext? defaultProduct,
  }) {
    ChatSellerInfo? resolvedSeller = defaultSeller;
    ChatProductContext? resolvedProduct = defaultProduct;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is ChatSellerInfo) {
        resolvedSeller = args;
      } else if (args is ProductPreview) {
        resolvedProduct = ChatProductContext.fromProduct(args);
        resolvedSeller = ChatSellerInfo.fromBrand(
          args.brand,
          rating: args.rating,
          ratingCount: args.ratingCount,
        );
      } else if (args is BrandModel) {
        resolvedSeller = ChatSellerInfo.fromBrand(args);
      } else if (args is Map<String, dynamic>) {
        if (args['seller'] is ChatSellerInfo) {
          resolvedSeller = args['seller'];
        } else if (args['brand'] is BrandModel) {
          resolvedSeller = ChatSellerInfo.fromBrand(
            args['brand'],
            rating: args['rating'],
            ratingCount: args['ratingCount'] ?? 0,
          );
        } else if (args['seller'] is Map<String, dynamic>) {
          resolvedSeller = ChatSellerInfo.fromJson(args['seller']);
        }

        if (args['product'] is ChatProductContext) {
          resolvedProduct = args['product'];
        } else if (args['product'] is ProductPreview) {
          resolvedProduct = ChatProductContext.fromProduct(args['product']);
        } else if (args['product'] is Map<String, dynamic>) {
          resolvedProduct = ChatProductContext.fromJson(args['product']);
        }
      }
    }

    resolvedSeller ??= ChatSellerInfo(
      id: 0,
      name: "تاجر تروند",
      rating: 4.9,
      ratingCount: 18,
      isVerified: true,
      isOnline: true,
    );

    return ChatRouteData(
      seller: resolvedSeller,
      product: resolvedProduct,
    );
  }
}
