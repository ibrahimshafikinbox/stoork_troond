import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/brands/services/brand_services.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/services/product_services.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../../product/ui/product_card/product_card.dart';
import '../../../product/ui/product_card/product_card_3.dart';
import '../../../filter/ui/quick_filter/product_list_header.dart';

class BrandAllProduct extends StatefulWidget {
  const BrandAllProduct({super.key, required this.id});
  final int id;

  @override
  State<BrandAllProduct> createState() => _BrandAllProductState();
}

class _BrandAllProductState extends State<BrandAllProduct> {
  final ScrollController _scrollController = ScrollController();
  final List<ProductPreview> _products = [];

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialProducts();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll > 0 && currentScroll >= maxScroll - 150) {
      if (!_isLoading && !_isLoadingMore && _hasMore) {
        _fetchMoreProducts();
      }
    }
  }

  Future<void> _fetchInitialProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      PaginatedProductsResult res =
          await BrandServices().getPaginatedProductsByBrand(
        widget.id,
        page: 1,
        perPage: 10,
      );
      if (mounted) {
        setState(() {
          _products.clear();
          _products.addAll(res.products);
          _totalCount = res.totalCount > 0 ? res.totalCount : _products.length;
          _currentPage = res.currentPage;
          _hasMore = res.hasMore && res.products.isNotEmpty;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    int nextPage = _currentPage + 1;
    try {
      PaginatedProductsResult res =
          await BrandServices().getPaginatedProductsByBrand(
        widget.id,
        page: nextPage,
        perPage: 10,
      );
      if (mounted) {
        setState(() {
          if (res.products.isNotEmpty) {
            final existingIds = _products.map((e) => e.id).toSet();
            for (var p in res.products) {
              if (!existingIds.contains(p.id)) {
                _products.add(p);
              }
            }
            _currentPage = res.currentPage;
          }
          _totalCount = res.totalCount > 0 ? res.totalCount : _products.length;
          _hasMore = res.hasMore && res.products.isNotEmpty;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<ProductController>(context);
    final displayedProducts = productController.filterProductList(_products);

    return Padding(
      padding: const EdgeInsets.all(AppPadding.padding8),
      child: Column(
        children: [
          ProductListHeader(
            productController: productController,
            totalCount: _totalCount > 0 ? _totalCount : null,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: _isLoading
                ? (productController.isGridView
                    ? const ProductsShimmerLoading(
                        isHorizontal: false, itemCount: 6)
                    : const ProductsListShimmerLoading(itemCount: 6))
                : (displayedProducts.isEmpty
                    ? Center(
                        child: Text(
                          "لا توجد منتجات متوفرة حالياً لهذا التاجر",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            productController.isGridView
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    itemCount: displayedProducts.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.68,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                    ),
                                    itemBuilder: (context, index) {
                                      var product = displayedProducts[index];
                                      return ProductCard(
                                        product: product,
                                        imageHeight: 160,
                                      );
                                    },
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: displayedProducts.length,
                                    itemBuilder: (context, index) {
                                      return ProductCard3(
                                        product: displayedProducts[index],
                                      );
                                    },
                                  ),
                            if (_isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.main,
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
