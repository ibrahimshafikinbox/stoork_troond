import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';

class RateCard extends StatelessWidget {
  const RateCard({
    super.key,
    required this.product,
    this.starSize = 13.0,
    this.showNumber = true,
  });
  final ProductPreview product;
  final double starSize;
  final bool showNumber;

  @override
  Widget build(BuildContext context) {
    if (product.rating == null || product.rating == 0) {
      return const SizedBox();
    }

    final double rate = product.rating!.toDouble();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            if (index < rate.floor()) {
              return Icon(
                Icons.star_rounded,
                color: const Color(0xFFFFB800),
                size: starSize,
              );
            } else if (index < rate && rate % 1 != 0) {
              return Icon(
                Icons.star_half_rounded,
                color: const Color(0xFFFFB800),
                size: starSize,
              );
            } else {
              return Icon(
                Icons.star_rounded,
                color: const Color(0xFFE2E8F0),
                size: starSize,
              );
            }
          }),
        ),
        if (showNumber) ...[
          const SizedBox(width: 3),
          Text(
            rate % 1 == 0 ? rate.toInt().toString() : rate.toStringAsFixed(1),
            style: TextStyle(
              fontSize: starSize - 1,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ],
    );
  }
}
