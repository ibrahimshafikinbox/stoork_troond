import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'essential_details_widget.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.productPreview});
  final ProductPreview productPreview;

  @override
  Widget build(BuildContext context) {
    String currentLang = SharedPref.getLanguage();

    final hasDescription = productPreview.description.trim().isNotEmpty;
    final hasOverviewItems = productPreview.overveiw.isNotEmpty;
    final hasImages = productPreview.images.isNotEmpty;

    if (!hasDescription && !hasOverviewItems && !hasImages) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            currentLang == 'en'
                ? "No overview details available for this product"
                : "لا توجد تفاصيل متوفرة لهذا المنتج",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Description Paragraph (matching website layout)
        if (hasDescription) ...[
          Text(
            productPreview.description,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14.5,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (hasOverviewItems || hasImages) const SizedBox(height: 16),
        ],

        // 2. Essential Details / Overview Items List (matching website layout)
        if (hasOverviewItems) ...[
          EssentialDetailsWidget(overview: productPreview.overveiw),
          if (hasImages) const SizedBox(height: 16),
        ],

        // 3. All Product Images (displayed vertically below description)
        if (hasImages) ...[
          ...productPreview.images.map((img) {
            if (img.path.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: img.path,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.main,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}

