import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/product/model/product_preview.dart';

class SpecificationTab extends StatelessWidget {
  const SpecificationTab({super.key, required this.productPreview});
  final ProductPreview productPreview;

  @override
  Widget build(BuildContext context) {
    final options = productPreview.options;

    if (options.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Center(
          child: Text(
            "لا توجد مواصفات إضافية متوفرة لهذا المنتج",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: List.generate(options.length, (index) {
            final item = options[index];
            final bool isEven = index % 2 == 0;
            final bool isLast = index == options.length - 1;

            return Container(
              color: isEven ? const Color(0xFFF9FAFB) : Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            color: AppColor.c121212,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.value,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey.shade200,
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
