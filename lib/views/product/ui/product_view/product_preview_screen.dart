import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/services/product_services.dart';
import 'package:troond/views/product/ui/product_view/widget/guarantee_widget.dart';
import 'package:troond/views/product/ui/product_view/widget/layout_widget.dart';
import 'package:troond/views/product/ui/product_view/widget/product_images.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/overview/related_items.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/overview/seller_widget.dart';
import 'package:troond/views/product/ui/product_view/widget/product_tab_bar/product_tab_bar.dart';
import 'package:troond/views/product/ui/product_view/widget/product_title.dart';
import 'package:troond/views/search/ui/search_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/theme/app_color.dart';
import 'package:troond/widget/nav_bar/custom_bottom_nav_bar.dart';

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({super.key, required this.id});
  final int id;

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  late Future<ProductPreview?> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = PorductServices().getProduct(widget.id);
  }

  void _retry() {
    setState(() {
      _productFuture = PorductServices().getProduct(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = SharedPref.getLanguage() == 'en';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: AppColor.white,
        toolbarHeight: 45,
        elevation: 0.5,
        title: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: SearchBtn(),
        ),
        actions: const [],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: FutureBuilder<ProductPreview?>(
        future: _productFuture,
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(key: "${SharedConsts.product}${widget.id}");
          
          if (snapshot.connectionState == ConnectionState.waiting && cache == null) {
            return const LoadingWidget();
          }

          ProductPreview? productPreview;
          if (snapshot.hasData && snapshot.data != null) {
            productPreview = snapshot.data;
          } else if (cache != null) {
            try {
              var result = jsonDecode(cache);
              productPreview = ProductPreview.fromJson(result["data"]);
            } catch (_) {}
          }

          if (productPreview == null) {
            if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isEnglish
                            ? "Failed to load product details"
                            : "تعذر تحميل تفاصيل المنتج",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _retry,
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: Text(isEnglish ? "Retry" : "إعادة المحاولة"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.main,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const LoadingWidget();
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const SizedBox(height: 6),

              //* 1. Product Images Gallery
              ProductImagesWidget(productPreview: productPreview),

              //* 2. Product Title, Breadcrumb, Rating, Price, Size badge, Action Buttons (Send Inquiry, Chat Now)
              ProductTitle(productPreview: productPreview),

              //* 3. Size / Color Selector (if available)
              LayoutWidget(productPreview: productPreview),

              //* 4. Seller Card (matching troond.com)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: SellerWidget(
                  brand: productPreview.brand,
                  rating: productPreview.rating,
                  ratingCount: productPreview.ratingCount,
                ),
              ),

              //* 5. Quality & Compliance Guarantees Card (Free Returns, Secure Shopping, Quality Guarantee)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: GuaranteeWidget(),
              ),

              const SizedBox(height: 4),

              //* 6. Website Tab Bar (Overview & Review tabs)
              ProductTabBar(productPreview: productPreview),

              //* 7. Related Products Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RelatedItemsWidget(
                  relatedProduct: productPreview.relatedProducts,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


//* old

// class ProductPreviewScreen extends StatelessWidget {
//   const ProductPreviewScreen({super.key, required this.id});
//   final int id;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder<ProductPreview?>(
//         future: PorductServices().getProductById(id),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const LoadingWidget();
//           } else {
//             var productPreview = snapshot.data!;
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       //* images
//                       ProductImagesWidget(productPreview: productPreview),

//                       //* product title
//                       ProductTitle(productPreview: productPreview),

//                       //* price
//                       // ProductPrice(productPreview: productPreview),

//                       //* Size
//                       LayoutWidget(productPreview: productPreview),

//                       const SizedBox(height: 10),

//                       //* tab bar
//                       ProductTabBar(productPreview: productPreview),
//                     ],
//                   ),
//                 ),
//                 ProductPrice(productPreview: productPreview),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
