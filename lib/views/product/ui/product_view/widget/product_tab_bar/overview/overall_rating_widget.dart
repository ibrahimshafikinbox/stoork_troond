import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';

class OverallRatingWidget extends StatefulWidget {
  const OverallRatingWidget({
    super.key,
    required this.productPreview,
  });
  final ProductPreview productPreview;

  @override
  State<OverallRatingWidget> createState() => _OverallRatingWidgetState();
}

class _OverallRatingWidgetState extends State<OverallRatingWidget> {
  int initUser = 1;
  bool showBtn = true;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = SharedPref.getLanguage() == 'en';
    double ratingVal = (widget.productPreview.rating ?? 0.0).toDouble();
    int reviewCount = widget.productPreview.ratingCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Big Rating Summary Box (website design from screenshot)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Large Rating Number (e.g. 4.3)
              Text(
                "$ratingVal",
                style: const TextStyle(
                  color: Color(0xFFF97316),
                  fontWeight: FontWeight.w900,
                  fontSize: 42,
                  height: 1.0,
                ),
              ),

              const SizedBox(height: 8),

              // 5 Stars Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFF59E0B),
                    size: 24,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Reviews Count Subtitle
              Text(
                isEnglish
                    ? "$reviewCount Customer Reviews"
                    : "$reviewCount تقييمات العملاء",
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // 2. Reviews List if available
        if (widget.productPreview.review.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            isEnglish ? "Reviews" : "المراجعات",
            style: const TextStyle(
              color: AppColor.c121212,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: initUser.clamp(1, widget.productPreview.review.length),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = widget.productPreview.review[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColor.main,
                          backgroundImage: item.user.image.isNotEmpty
                              ? CachedNetworkImageProvider(item.user.image)
                              : null,
                          child: item.user.image.isEmpty
                              ? const Icon(Icons.person,
                                  size: 18, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.user.name,
                                style: const TextStyle(
                                  color: AppColor.c121212,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  item.rating,
                                  (i) => const Icon(
                                    Icons.star_rounded,
                                    size: 13,
                                    color: Color(0xFFF59E0B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.comment,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (widget.productPreview.review.length > 1 && showBtn)
            TextButton(
              onPressed: () {
                setState(() {
                  initUser = widget.productPreview.review.length;
                  showBtn = false;
                });
              },
              child: Text(
                isEnglish ? "View all reviews" : "عرض جميع التقييمات",
                style: const TextStyle(
                  color: AppColor.main,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

