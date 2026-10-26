import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/filter/ui/quick_filter/product_list_header.dart';
import 'package:troond/views/product/ui/product_grid/product_grid.dart';
import 'package:troond/views/product/ui/product_card/product_card_3.dart';
import '../../../../config/theme/app_color.dart';
import '../../../app_bar/app_bar_widget.dart';
import 'package:troond/widget/nav_bar/custom_bottom_nav_bar.dart';

class ProductsGroupScreen extends StatefulWidget {
  const ProductsGroupScreen({super.key, required this.products});
  final List<ProductPreview> products;

  @override
  State<ProductsGroupScreen> createState() => _ProductsGroupScreenState();
}

class _ProductsGroupScreenState extends State<ProductsGroupScreen> {
  @override
  Widget build(BuildContext context) {
    ProductController productController =
        Provider.of<ProductController>(context);
    final displayedProducts =
        productController.filterProductList(widget.products);

    return Scaffold(
      appBar: const CustomAppBar.search(hasLead: true),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductListHeader(productController: productController),
              displayedProducts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Center(
                        child: Text(
                          "لا توجد منتجات تطابق الفلترة المحّددة",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : productController.isGridView
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
              displayedProducts.length <= 10
                  ? const SizedBox()
                  : NumberPaginator(
                      numberPages: displayedProducts.length,
                      onPageChange: (int index) {},
                      showPrevButton: true,
                      showNextButton: false,
                      nextButtonContent: const Icon(Icons.arrow_right_alt),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
