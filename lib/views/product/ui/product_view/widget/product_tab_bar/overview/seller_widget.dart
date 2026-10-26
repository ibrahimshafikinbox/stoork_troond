import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/brands/model/brand_model.dart';

class SellerWidget extends StatelessWidget {
  const SellerWidget({
    super.key,
    required this.brand,
    this.rating,
    this.ratingCount = 0,
  });
  final BrandModel? brand;
  final double? rating;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    if (brand == null || brand!.name.isEmpty) return const SizedBox.shrink();

    bool isEnglish = SharedPref.getLanguage() == 'en';
    String initials = brand!.name.trim().isNotEmpty
        ? brand!.name.trim().substring(0, brand!.name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : "TR";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Seller Info Row
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A3B5),
                  shape: BoxShape.circle,
                  image: brand!.logo.isNotEmpty
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(brand!.logo),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: brand!.logo.isEmpty
                    ? Center(
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: 12),

              // Seller Name & Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? "SELLER" : "البائع",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      brand!.name,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFF10B981),
                          size: 15,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isEnglish ? "Verified Seller" : "بائع معتمد",
                          style: const TextStyle(
                            color: Color(0xFF059669),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // Star Rating Row
                    if (rating != null && rating! > 0) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(5, (i) {
                            double starVal = rating!;
                            IconData icon;
                            if (i < starVal.floor()) {
                              icon = Icons.star_rounded;
                            } else if (i < starVal && starVal - i >= 0.5) {
                              icon = Icons.star_half_rounded;
                            } else {
                              icon = Icons.star_border_rounded;
                            }
                            return Icon(
                              icon,
                              color: const Color(0xFFFBBF24),
                              size: 16,
                            );
                          }),
                          const SizedBox(width: 4),
                          Text(
                            "(${rating!.toStringAsFixed(1)})",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (ratingCount > 0) ...[
                            const SizedBox(width: 4),
                            Text(
                              isEnglish
                                  ? "$ratingCount Reviews"
                                  : "$ratingCount تقييم",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 2. Action Buttons (Contact Seller & Visit Store)
          Row(
            children: [
              // Contact Seller Button
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.chatScreen,
                      arguments: {
                        'brand': brand,
                        'rating': rating,
                        'ratingCount': ratingCount,
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Color(0xFF2563EB),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isEnglish ? "Contact" : "تواصل مع البائع",
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Visit Store Button
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.brandScreen,
                      arguments: brand!.id,
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.storefront_outlined,
                          color: Color(0xFFF97316),
                          size: 17,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isEnglish ? "Store" : "المتجر",
                          style: const TextStyle(
                            color: AppColor.c121212,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          isEnglish ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
                          color: Colors.grey.shade600,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

