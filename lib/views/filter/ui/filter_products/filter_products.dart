import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/filter/ui/btn/filter_button.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/filter/ui/quick_filter/product_list_header.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/views/product/ui/product_card/product_card.dart';
import 'package:troond/views/product/ui/product_card/product_card_3.dart';
import '../../../app_bar/app_bar_widget.dart';
import 'package:troond/widget/nav_bar/custom_bottom_nav_bar.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key, required this.future});
  final Future<List<ProductPreview>>? future;

  @override
  Widget build(BuildContext context) {
    ProductController productController =
        Provider.of<ProductController>(context);
    return Scaffold(
      appBar: const CustomAppBar.search(hasLead: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FilterButton(),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Column(
        children: [
          ProductListHeader(productController: productController),
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder<List<ProductPreview>>(
              future: future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LoadingWidget();
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: productController.isGridView ? 2 : 1,
                      childAspectRatio:
                          productController.isGridView ? 0.60 : 1.8,
                    ),
                    itemBuilder: (context, index) {
                      var product = snapshot.data![index];
                      return productController.isGridView
                          ? ProductCard(product: product)
                          : ProductCard3(product: product);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
