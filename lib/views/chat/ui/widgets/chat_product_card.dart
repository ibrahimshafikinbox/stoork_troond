import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/chat/model/chat_product_context.dart';

class ChatProductCard extends StatelessWidget {
  final ChatProductContext product;
  final VoidCallback? onClose;

  const ChatProductCard({
    super.key,
    required this.product,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnglish = SharedPref.getLanguage() == 'en';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 58,
              height: 58,
              color: const Color(0xFFF9FAFB),
              child: product.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColor.main,
                    ),
            ),
          ),

          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isEnglish ? "Inquiring about" : "استفسار عن هذا المنتج",
                        style: const TextStyle(
                          color: AppColor.main,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      "${product.price} ${AppStrings.currecy}",
                      style: const TextStyle(
                        color: AppColor.main,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    if (product.basePrice != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        "${product.basePrice} ${AppStrings.currecy}",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          if (onClose != null)
            IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 18,
                color: Colors.grey.shade400,
              ),
              onPressed: onClose,
              splashRadius: 18,
            ),
        ],
      ),
    );
  }
}
