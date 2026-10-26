import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/widget/cell/build_category.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../product/services/product_services.dart';
import '../../model/home_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.homeModel});
  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    List<CategoryModel> categoryList = homeModel.categories;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              local.categories,
              style: const TextStyle(
                color: AppColor.c121212,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 155,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categoryList.length,
              separatorBuilder: (context, index) => const SizedBox(width: 2),
              itemBuilder: (context, index) {
                var category = categoryList[index];
                return BuildCategory(
                  name: category.name,
                  image: category.image,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.productsListScreen,
                      arguments: {
                        'categoryId': category.id,
                        'title': category.name,
                        'future': PorductServices().getProductsByCategoryId(
                          category.id,
                        ),
                      },
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
}
