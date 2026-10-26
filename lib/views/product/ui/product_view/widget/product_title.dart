import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key, required this.productPreview});
  final ProductPreview productPreview;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = SharedPref.getLanguage() == 'en';

    bool hasCategory = productPreview.category != null &&
        productPreview.category!.name.trim().isNotEmpty;
    bool hasDiscount =
        productPreview.discount.isNotEmpty && productPreview.discount != "0";
    bool hasBasePrice = productPreview.basePrice.isNotEmpty &&
        productPreview.basePrice != productPreview.price.toString();
    bool hasRating = productPreview.rating != null && productPreview.rating! > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Breadcrumbs Category & Rating Row (matching website top bar)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (hasCategory)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          productPreview.category!.name,
                          style: const TextStyle(
                            color: Color(0xFF4B5563),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF9CA3AF),
                        size: 18,
                      ),
                    ],
                  ),
                )
              else
                const SizedBox.shrink(),

              if (hasRating || productPreview.ratingCount > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 17,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      (productPreview.rating ?? 0.0).toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "(${productPreview.ratingCount} ${isEnglish ? 'Review' : 'تقييم'})",
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 8),

          // 2. Product Name Title
          Text(
            productPreview.name,
            style: const TextStyle(
              color: AppColor.c121212,
              fontWeight: FontWeight.bold,
              fontSize: 19,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 10),

          // 3. Price Display Box
          Row(
            children: [
              Text(
                "${productPreview.price}",
                style: const TextStyle(
                  color: AppColor.main,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                AppStrings.currecy,
                style: TextStyle(
                  color: AppColor.main,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (hasBasePrice) ...[
                const SizedBox(width: 10),
                Text(
                  "${productPreview.basePrice} ${AppStrings.currecy}",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              if (hasDiscount) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "-${productPreview.discount}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 12),

          // 4. Size Header & Badge (matching website)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEnglish ? "Size" : "المقاس",
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.straighten_rounded,
                      size: 17,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isEnglish
                          ? "Multiple sizes available on demand"
                          : "تتوفر مقاسات متعددة حسب الطلب",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 5. Action Buttons (Send Inquiry & Contact Seller) - Website layout
          Row(
            children: [
              // Send Inquiry (Orange Button)
              Expanded(
                flex: 6,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.chatScreen,
                      arguments: {
                        'product': productPreview,
                        'brand': productPreview.brand,
                        'rating': productPreview.rating,
                        'ratingCount': productPreview.ratingCount,
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: Text(
                    isEnglish ? "Send Inquiry" : "إرسال استفسار",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF97316),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Contact Seller (Light Blue / Troond Style Button)
              Expanded(
                flex: 6,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.chatScreen,
                      arguments: {
                        'product': productPreview,
                        'brand': productPreview.brand,
                        'rating': productPreview.rating,
                        'ratingCount': productPreview.ratingCount,
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Color(0xFF2563EB),
                    size: 16,
                  ),
                  label: Text(
                    isEnglish ? "Contact Seller" : "تواصل مع البائع",
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFF6FF),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    side: const BorderSide(color: Color(0xFFBFDBFE)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

