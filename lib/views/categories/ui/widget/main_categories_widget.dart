import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/widget/btn/more_btn.dart';
import 'package:troond/widget/cell/build_category.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../../home/model/category_model.dart';
import '../../../main_screen/controller/main_controller.dart';
import '../../../product/services/product_services.dart';

class MainCategoriesWidget extends StatelessWidget {
  const MainCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.padding8),
      child: FutureBuilder<List<CategoryModel>>(
        future: CategoriesServices().getCategories(),
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(key: SharedConsts.categories);
          if (cache == null && !snapshot.hasData) {
            return const CategoriesShimmerLoading();
          } else {
            if (cache == null) return const CategoriesShimmerLoading();
            var data = jsonDecode(cache);
            List<CategoryModel> categoriesList = [];
            for (var element in data["data"]) {
              categoriesList.add(CategoryModel.fromJson(element));
            }

            List<CategoryModel> result =
                snapshot.hasData ? snapshot.data! : categoriesList;
            result.removeWhere((element) => element.parent == null);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        local.categories,
                        style: const TextStyle(
                          color: AppColor.c121212,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      MoreBtn(
                        onTap: () {
                          Provider.of<MainController>(context, listen: false)
                              .changeIndex(1, context);
                        },
                      ),
                    ],
                  ),
                ),
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
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      var category = result[index];
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
            );
          }
        },
      ),
    );
  }
}
