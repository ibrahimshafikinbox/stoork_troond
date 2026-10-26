import 'package:flutter/material.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/brands/widget/best_seller_widget.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/home/ui/widgets/sale_widget.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_grid/product_grid.dart';
// import 'package:troond/widget/cell/build_category.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../ads/models/ads_model.dart';
import '../../../ads/services/ads_services.dart';

class BrandHome extends StatefulWidget {
  const BrandHome({
    super.key,
    required this.id,
    required this.bestSeller,
    required this.categries,
    required this.products,
  });
  final int id;
  final List<ProductPreview> bestSeller;
  final List<ProductPreview> products;
  final List<CategoryModel> categries;

  @override
  State<BrandHome> createState() => _BrandHomeState();
}

class _BrandHomeState extends State<BrandHome> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    // Filter products by selected category if active
    List<ProductPreview> displayProducts = selectedCategoryId == null
        ? widget.products
        : widget.products
            .where((p) => p.category?.id == selectedCategoryId)
            .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          //* Ads section
          FutureBuilder<List<AdsModel>>(
            future: AdsServices().getAdsByBrandId(widget.id),
            builder: (context, snapshot) {
              List<AdsModel> result = snapshot.hasData ? snapshot.data! : [];
              return SaleWidget(adsModels: result);
            },
          ),

          /* Commented out Categories section per user request:
          widget.categries.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            local.categories,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          if (selectedCategoryId != null)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = null;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                child: Text(
                                  local.localeName == 'ar'
                                      ? 'عرض الكل'
                                      : 'Show All',
                                  style: const TextStyle(
                                    color: AppColor.main,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 135,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.categries.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            var item = widget.categries[index];
                            bool isSelected = selectedCategoryId == item.id;
                            return BuildCategory(
                              name: item.name,
                              image: item.image,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  if (selectedCategoryId == item.id) {
                                    selectedCategoryId = null;
                                  } else {
                                    selectedCategoryId = item.id;
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          */

          //* Best seller section (hide when category filter is active to focus on filtered products)
          widget.bestSeller.isEmpty || selectedCategoryId != null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding8,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            local.bestSeller,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productsGroupScreen,
                                arguments: widget.bestSeller,
                              );
                            },
                            child: Text(
                              local.all,
                              style: const TextStyle(
                                color: AppColor.main,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 215,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.bestSeller.length >= 6
                              ? 6
                              : widget.bestSeller.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return BestSellerWidget(
                              product: widget.bestSeller[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

          //* Products section (filtered or all)
          displayProducts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.storefront_outlined,
                          size: 56,
                          color: Color(0xFFCED4DA),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          selectedCategoryId != null
                              ? (local.localeName == 'ar'
                                  ? 'لا توجد منتجات متوفرة في هذا التصنيف'
                                  : 'No products available in this category')
                              : (local.localeName == 'ar'
                                  ? 'لا توجد منتجات متوفرة لهذه الماركة حالياً'
                                  : 'No products available for this brand currently'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (selectedCategoryId != null) ...[
                          const SizedBox(height: 14),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedCategoryId = null;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColor.main,
                              side: const BorderSide(color: AppColor.main),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              local.localeName == 'ar'
                                  ? 'إظهار كافة المنتجات'
                                  : 'Show All Products',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding8,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedCategoryId != null
                                ? "${local.product} (${displayProducts.length})"
                                : local.product,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productsGroupScreen,
                                arguments: displayProducts,
                              );
                            },
                            child: Text(
                              local.all,
                              style: const TextStyle(
                                color: AppColor.main,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      BuildProductGrid(productList: displayProducts),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
