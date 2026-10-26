import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/overview/overall_rating_widget.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/overview/overview_tab.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/specification/specification_tab.dart';

class ProductTabBar extends StatefulWidget {
  const ProductTabBar({
    super.key,
    required this.productPreview,
  });
  final ProductPreview productPreview;

  @override
  State<ProductTabBar> createState() => _ProductTabBarState();
}

class _ProductTabBarState extends State<ProductTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    String lang = SharedPref.getLanguage();
    bool isEnglish = lang == 'en';

    final bool hasSpecs = widget.productPreview.options.isNotEmpty;

    String overviewTitle = isEnglish
        ? 'Overview'
        : (local.overview.isNotEmpty ? local.overview : 'الوصف والخصائص');
    String specsTitle = isEnglish
        ? 'Specifications'
        : (local.specification.isNotEmpty ? local.specification : 'المواصفات');
    int reviewCount = widget.productPreview.ratingCount;
    String reviewsTitle = isEnglish
        ? 'Review ($reviewCount)'
        : 'التقييمات ($reviewCount)';

    List<_TabItem> tabs = [
      _TabItem(
        index: 0,
        label: overviewTitle,
        icon: Icons.article_outlined,
      ),
    ];
    if (hasSpecs) {
      tabs.add(_TabItem(
        index: 1,
        label: specsTitle,
        icon: Icons.tune_outlined,
      ));
    }
    tabs.add(_TabItem(
      index: 2,
      label: reviewsTitle,
      icon: Icons.star_outline_rounded,
    ));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tab Bar Pill Buttons Header Row (website style)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: tabs.map((tab) {
                  final bool isSelected = _selectedIndex == tab.index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = tab.index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFF7ED)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.main
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              tab.icon,
                              size: 17,
                              color: isSelected
                                  ? AppColor.main
                                  : const Color(0xFF6B7280),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              tab.label,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColor.main
                                    : const Color(0xFF4B5563),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // 2. Divider Line
            const Divider(height: 1, color: Color(0xFFF3F4F6)),

            // 3. Tab Body Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: _selectedIndex == 0
                  ? OverviewTab(productPreview: widget.productPreview)
                  : (_selectedIndex == 1 && hasSpecs)
                      ? SpecificationTab(productPreview: widget.productPreview)
                      : OverallRatingWidget(
                          productPreview: widget.productPreview),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem {
  final int index;
  final String label;
  final IconData icon;

  _TabItem({
    required this.index,
    required this.label,
    required this.icon,
  });
}

