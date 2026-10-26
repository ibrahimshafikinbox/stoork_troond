import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/product/services/product_services.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';

class SubCategoriesGrid extends StatelessWidget {
  const SubCategoriesGrid({
    super.key,
    required this.activeCategory,
    required this.subcategories,
    required this.isLoading,
  });

  final CategoryModel activeCategory;
  final List<CategoryModel>? subcategories;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              local.subcategories,
              style: const TextStyle(
                color: AppColor.c121212,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subcategories != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDADCE3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${subcategories!.length} ${local.categoryCountSuffix}",
                  style: const TextStyle(
                    color: AppColor.c414141,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),

        // Content: Loading / Grid / Empty
        if (isLoading)
          _buildShimmerGrid()
        else if (subcategories != null && subcategories!.isNotEmpty)
          _buildSubcatGrid(context)
        else
          _buildEmptyState(context, local),
      ],
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerWidget.rectangular(height: 95, width: 95),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 14, width: 80),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubcatGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: subcategories!.length,
      itemBuilder: (context, index) {
        var subcat = subcategories![index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _onCategoryTap(context, subcat),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: _buildContainImage(subcat.image),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subcat.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// عرض الصورة بأبعادها الكاملة بدون قص باستخدام BoxFit.contain
  Widget _buildContainImage(String imageUrl) {
    if (imageUrl.isEmpty || !imageUrl.startsWith('http')) {
      return Container(
        color: Colors.grey.shade100,
        child: const Center(
          child: Icon(Icons.image_not_supported, color: Colors.grey),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade100,
        child: const Center(
          child: Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, dynamic local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category_outlined,
            size: 44,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          Text(
            local.noSubcategoriesAvailable,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productsListScreen,
                arguments: {
                  'categoryId': activeCategory.id,
                  'title': activeCategory.name,
                  'future': PorductServices().getProductsByCategoryId(
                    activeCategory.id,
                  ),
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.main,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(Icons.grid_view_rounded, size: 16),
            label: Text(
              local.browseAllProducts,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCategoryTap(BuildContext context, CategoryModel category) {
    if (category.children.isNotEmpty) {
      Navigator.of(context).pushNamed(
        AppRoutes.subCategoryScreen,
        arguments: category,
      );
    } else {
      Navigator.of(context).pushNamed(
        AppRoutes.productsListScreen,
        arguments: {
          'categoryId': category.id,
          'title': category.name,
          'future': PorductServices().getProductsByCategoryId(category.id),
        },
      );
    }
  }
}
