import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/views/brands/model/brand_preview.dart';
import 'package:troond/views/brands/services/brand_services.dart';
import 'package:troond/views/brands/ui/all/brand_all_product.dart';
// import 'package:troond/views/brands/ui/home/brand_home.dart';
import 'package:troond/views/search/ui/search_btn.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Material(
      color: AppColor.white,
      child: FutureBuilder<BranPreview?>(
        future: BrandServices().getSingleBrand(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BrandProfileShimmerLoading();
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Scaffold(
              backgroundColor: AppColor.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: AppColor.c121212),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.branding_watermark_outlined,
                        size: 56,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        local.errorTryAgain,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.c121212,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          var branPreview = snapshot.data!;
          var brand = branPreview.brand;
          // var categries = branPreview.categries;
          bool hasValidLogo =
              brand.logo.isNotEmpty && brand.logo.startsWith("http");

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              leading: const BackButton(color: AppColor.c121212),
              title: Text(
                brand.name,
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.main.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${branPreview.products.length} ${local.product}",
                        style: const TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                // Brand Profile Hero Card
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE8ECEF),
                      width: 1.2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE8ECEF),
                                width: 1,
                              ),
                            ),
                            child: hasValidLogo
                                ? CachedNetworkImage(
                                    imageUrl: brand.logo,
                                    fit: BoxFit.contain,
                                    placeholder: (_, __) => const Center(
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColor.main,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (_, __, ___) =>
                                        const Icon(
                                      Icons.branding_watermark_outlined,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                  )
                                : const Icon(
                                    Icons.branding_watermark_outlined,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        brand.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColor.c121212,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${branPreview.products.length} ${local.product}",
                                  style: const TextStyle(
                                    color: Color(0xFF868E96),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const SearchBtn(),
                    ],
                  ),
                ),

                // Products belonging to this merchant/brand
                Expanded(
                  child: BrandAllProduct(id: id),
                ),

                /* Commented out TabBar (Home & All Products) per user request:
                DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (
                      BuildContext context,
                      bool innerBoxIsScrolled,
                    ) {
                      return <Widget>[
                        // Modern TabBar
                        SliverAppBar(
                          floating: true,
                          pinned: true,
                          elevation: 0.5,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.white,
                          toolbarHeight: 0,
                          bottom: TabBar(
                            labelColor: AppColor.main,
                            unselectedLabelColor: const Color(0xFF868E96),
                            indicatorColor: AppColor.main,
                            indicatorWeight: 3,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            tabs: [
                              Tab(text: local.home),
                              Tab(text: local.allProduct),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BrandHome(
                          id: id,
                          bestSeller: branPreview.mostSold,
                          products: branPreview.products,
                          categries: categries,
                        ),
                        BrandAllProduct(id: id),
                      ],
                    ),
                  ),
                ),
                */
              ],
            ),
          );
        },
      ),
    );
  }
}
