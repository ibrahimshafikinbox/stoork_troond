import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/services/product_services.dart';
import 'package:troond/views/filter/ui/quick_filter/product_list_header.dart';
import 'package:troond/views/product/ui/product_grid/product_grid.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import 'package:troond/views/product/ui/product_card/product_card_3.dart';
import '../../../../config/theme/app_color.dart';
import '../../../app_bar/app_bar_widget.dart';
import 'package:troond/widget/nav_bar/custom_bottom_nav_bar.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({
    super.key,
    this.future,
    this.categoryId,
    this.title,
    this.initialProducts,
  });

  final Future<List<ProductPreview>>? future;
  final int? categoryId;
  final String? title;
  final List<ProductPreview>? initialProducts;

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
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
    if (widget.initialProducts != null && widget.initialProducts!.isNotEmpty) {
      _products.addAll(widget.initialProducts!);
      _isLoading = false;
    }
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
    if (_products.isEmpty) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      PaginatedProductsResult res =
          await PorductServices().getPaginatedProducts(
        categoryId: widget.categoryId,
        page: 1,
        perPage: 10,
      );
      if (mounted) {
        setState(() {
          if (res.products.isNotEmpty) {
            // Deduplicate with initial items
            final existingIds = _products.map((e) => e.id).toSet();
            for (var p in res.products) {
              if (!existingIds.contains(p.id)) {
                _products.add(p);
              }
            }
          }
          _totalCount = res.totalCount > 0 ? res.totalCount : _products.length;
          _currentPage = res.currentPage;
          _hasMore = res.hasMore && res.products.isNotEmpty;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (widget.future != null) {
        try {
          List<ProductPreview> list = await widget.future!;
          if (mounted) {
            setState(() {
              if (list.isNotEmpty) {
                _products.clear();
                _products.addAll(list);
              }
              _totalCount = _products.length;
              _hasMore = false;
              _isLoading = false;
            });
          }
        } catch (_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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
          await PorductServices().getPaginatedProducts(
        categoryId: widget.categoryId,
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
    ProductController productController =
        Provider.of<ProductController>(context);
    final displayedProducts =
        productController.filterProductList(_products);

    return Scaffold(
      appBar: const CustomAppBar.search(hasLead: true),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: _isLoading
          ? Padding(
              padding: const EdgeInsets.all(AppPadding.padding8),
              child: Column(
                children: [
                  ProductListHeader(
                    productController: productController,
                    totalCount: _totalCount,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: productController.isGridView
                          ? const ProductsShimmerLoading(
                              isHorizontal: false,
                              itemCount: 6,
                            )
                          : const ProductsListShimmerLoading(itemCount: 5),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.padding8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title if available
                    if (widget.title != null && widget.title!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: Text(
                          widget.title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColor.c121212,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // Filter, Grid/List view mode, and Total Count Header Row
                    ProductListHeader(
                      productController: productController,
                      totalCount: _totalCount > 0 ? _totalCount : null,
                    ),

                    if (_products.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Center(
                          child: Text(
                            "لا توجد منتجات متوفرة حالياً في هذا القسم",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    else if (displayedProducts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Center(
                          child: Text(
                            "لا توجد منتجات تطابق نتائج الفلترة",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    else
                      productController.isGridView
                          ? BuildProductGrid(productList: displayedProducts)
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(color: AppColor.cDADCE3),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: displayedProducts.length,
                              itemBuilder: (context, index) {
                                return ProductCard3(
                                  product: displayedProducts[index],
                                );
                              },
                            ),

                    // Bottom Pagination Spinner
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
              ),
            ),
    );
  }
}
