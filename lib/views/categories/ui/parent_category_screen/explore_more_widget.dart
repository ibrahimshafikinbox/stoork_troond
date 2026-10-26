import 'package:flutter/material.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_grid/product_grid.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../product/services/product_services.dart';

class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key, required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return FutureBuilder<List<ProductPreview>>(
      future: PorductServices().getProductsByCategoryId(categoryId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ProductsShimmerLoading(isHorizontal: false, itemCount: 4),
          );
        } else {
          var result = snapshot.data!;
          return result.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(AppPadding.padding8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          local.exploreMore,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColor.c000000,
                          ),
                        ),
                      ),
                      BuildProductGrid(productList: result),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.productsListScreen,
                                  arguments: PorductServices()
                                      .getProductsByCategoryId(categoryId),
                                );
                              },
                              label: Text(
                                local.seeAll,
                                style: const TextStyle(
                                  color: AppColor.c121212,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: AppColor.c121212,
                                size: 18,
                              ),
                            ),
                          ),
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
