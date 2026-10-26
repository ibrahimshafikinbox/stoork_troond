import 'package:flutter/material.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_color.dart';
import '../../../app_bar/app_bar_widget.dart';
import '../../../home/model/category_model.dart';
import '../../../product/services/product_services.dart';
import '../../../../widget/images/cache_image.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.parentCategory});
  final CategoryModel parentCategory;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    final subcategories = parentCategory.children;

    return Scaffold(
      appBar: const CustomAppBar.search(hasLead: true),
      body: CustomScrollView(
        slivers: [
          //* Hero Header
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF1a1a2e),
                    Color(0xFF16213e),
                    Color(0xFF0f3460),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //* Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.main.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColor.main.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        local.categories,
                        style: const TextStyle(
                          color: AppColor.main,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    //* Category name
                    Text(
                      parentCategory.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //* Subtitle
                    Text(
                      parentCategory.description.isNotEmpty
                          ? parentCategory.description
                          : local.explore,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    //* Browse Products button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.productsListScreen,
                          arguments: {
                            'categoryId': parentCategory.id,
                            'title': parentCategory.name,
                            'future': PorductServices().getProductsByCategoryId(
                              parentCategory.id,
                            ),
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.arrow_back, size: 18),
                      label: Text(
                        local.explore,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //* Subcategories Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.categories,
                    style: const TextStyle(
                      color: AppColor.c121212,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      '${subcategories.length}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //* Subcategories Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.72,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subcat = subcategories[index];
                  return _SubcategoryCard(
                    category: subcat,
                    onTap: () => _onSubcategoryTap(context, subcat),
                  );
                },
                childCount: subcategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubcategoryTap(BuildContext context, CategoryModel subcat) {
    if (subcat.children.isNotEmpty) {
      Navigator.of(context).pushNamed(
        AppRoutes.subCategoryScreen,
        arguments: subcat,
      );
    } else {
      Navigator.of(context).pushNamed(
        AppRoutes.productsListScreen,
        arguments: {
          'categoryId': subcat.id,
          'title': subcat.name,
          'future': PorductServices().getProductsByCategoryId(subcat.id),
        },
      );
    }
  }
}

class _SubcategoryCard extends StatelessWidget {
  const _SubcategoryCard({
    required this.category,
    required this.onTap,
  });
  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BuildCacheImage(
                    imageUrl: category.image,
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
              child: Text(
                category.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
