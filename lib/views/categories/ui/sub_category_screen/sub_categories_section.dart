import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/views/product/services/product_services.dart';
import '../../../../config/routes/app_routes.dart';

class SubCategoriesSection extends StatelessWidget {
  const SubCategoriesSection({
    super.key,
    required this.mainController,
    this.parentCategoryList,
  });
  final MainController mainController;
  final List<CategoryModel>? parentCategoryList;

  @override
  Widget build(BuildContext context) {
    CategoryModel? activeCategory;
    if (parentCategoryList != null &&
        mainController.activeCategories < parentCategoryList!.length) {
      activeCategory = parentCategoryList![mainController.activeCategories];
    }

    if (mainController.newSubCategories.isEmpty) {
      if (activeCategory == null) {
        return const Expanded(
          flex: 3,
          child: Center(
            child: Text(
              "اختر قسم من القائمة الجانبية",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }
      return Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (activeCategory.image.isNotEmpty)
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: activeCategory.image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.category, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                activeCategory.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c121212,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productsListScreen,
                    arguments: PorductServices().getProductsByCategoryId(
                      activeCategory!.id,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.grid_view_rounded, size: 20),
                label: const Text(
                  "عرض منتجات هذا القسم",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: mainController.newSubCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.60,
          ),
          itemBuilder: (context, index) {
            var categoories = mainController.newSubCategories[index];
            return InkWell(
              onTap: () {
                if (categoories.children.isNotEmpty) {
                  Navigator.of(context).pushNamed(
                    AppRoutes.subCategoryScreen,
                    arguments: categoories.children,
                  );
                } else {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productsListScreen,
                    arguments: PorductServices().getProductsByCategoryId(
                      categoories.id,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColor.cDBDBDB,
                    backgroundImage:
                        CachedNetworkImageProvider(categoories.image),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 85,
                    child: Text(
                      categoories.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
