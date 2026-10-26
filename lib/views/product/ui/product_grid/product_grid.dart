import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:troond/views/product/model/product_preview.dart';
import '../product_card/product_card.dart';

class BuildProductGrid extends StatelessWidget {
  const BuildProductGrid({
    super.key,
    required this.productList,
    this.isFav = false,
  });
  final List<ProductPreview> productList;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: [
        for (int i = 0; i < productList.length; i++)
          ProductCard(product: productList[i], isFav: isFav)
      ],
    );
  }
}
