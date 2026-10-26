import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import '../../../../product_card/related_product_card.dart';

class RelatedItemsWidget extends StatelessWidget {
  const RelatedItemsWidget({super.key, required this.relatedProduct});
  final List<RelatedProduct> relatedProduct;

  @override
  Widget build(BuildContext context) {
    if (relatedProduct.isEmpty) return const SizedBox.shrink();

    bool isEnglish = SharedPref.getLanguage() == 'en';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Section Header Row (website style)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColor.main.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.grid_view_rounded,
                color: AppColor.main,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnglish ? "Related Products" : "منتجات ذات صلة",
                    style: const TextStyle(
                      color: AppColor.c121212,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    isEnglish
                        ? "Explore similar products and categories"
                        : "استكشف منتجات وفئات مماثلة",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Related Products List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: relatedProduct.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RelatedProductCard(product: relatedProduct[index]),
            );
          },
        ),
      ],
    );
  }
}

