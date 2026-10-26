import 'package:flutter/material.dart';
import 'package:troond/config/padding/app_padding.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../widget/cell/build_category.dart';
import '../../../../widget/loading/shimmer_widget.dart';
import '../../../home/model/category_model.dart';
import '../../../product/services/product_services.dart';
import '../../services/categories_services.dart';

class ShopByCategoriesWidget extends StatelessWidget {
  const ShopByCategoriesWidget({super.key, required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return FutureBuilder<List<CategoryModel>>(
      future: CategoriesServices().getCategoryId(categoryId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CategoriesShimmerLoading();
        } else {
          var categoryList = snapshot.data!;
          return categoryList.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: AppPadding.padding8),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        local.shopByCategories,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColor.c000000,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 120,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.40,
                            mainAxisSpacing: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            var category = categoryList[index];
                            return BuildCategory(
                              name: category.name,
                              image: category.image,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.productsListScreen,
                                  arguments:
                                      PorductServices().getProductsByCategoryId(
                                    category.id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        }
      },
    );
  }
}
