import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_list/prodcts_list_screen.dart';

class ProductsListScreen2 extends StatelessWidget {
  const ProductsListScreen2({
    super.key,
    required this.productList,
    this.title,
  });
  final List<ProductPreview> productList;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ProductsListScreen(
      initialProducts: productList,
      title: title,
    );
  }
}
