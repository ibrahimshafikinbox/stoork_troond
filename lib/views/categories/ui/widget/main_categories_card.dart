import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/widget/images/cache_image.dart';

class MainCategoriesCard extends StatelessWidget {
  const MainCategoriesCard({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelectCategory,
  });

  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.mainDepartments,
            style: const TextStyle(
              color: AppColor.c717171,
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              var category = categories[index];
              bool isSelected = index == selectedIndex;

              return InkWell(
                onTap: () => onSelectCategory(index),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.main.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: AppColor.main, width: 1.5)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BuildCacheImage(
                          imageUrl: category.image,
                          height: 42,
                          width: 42,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: AppColor.c121212,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w600,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Directionality.of(context) == TextDirection.rtl
                              ? Icons.arrow_back_ios_rounded
                              : Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColor.main,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
