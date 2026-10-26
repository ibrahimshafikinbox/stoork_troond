import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/app_method.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';

import '../../../../config/app_local/app_local.dart';

class ShopByBrandWidget extends StatelessWidget {
  const ShopByBrandWidget({super.key, required this.categoryId});

  final int categoryId;
  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return FutureBuilder<List<BrandModel>>(
      future: CategoriesServices().getShopByBrand(categoryId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const BrandsShimmerLoading();
        } else {
          return snapshot.data!.isEmpty
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.cFFF4DF.withOpacity(0.30),
                        AppColor.cFFF4DF.withOpacity(0.1),
                        AppColor.cFFF4DF.withOpacity(0.1),
                        AppColor.cFFF4DF.withOpacity(0.30),
                      ],
                      begin: Alignment.center,
                      end: Alignment.center,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            local.shopOnBrand,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var brandModel = snapshot.data![index];
                            Color color = AppMethod().hexToColor(
                              brandModel.color,
                            );
                            bool hasValidLogo = brandModel.logo.isNotEmpty && brandModel.logo.startsWith("http");

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.brandScreen,
                                  arguments: brandModel.id,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: color,
                                      backgroundImage: hasValidLogo
                                          ? CachedNetworkImageProvider(brandModel.logo)
                                          : null,
                                      child: hasValidLogo
                                          ? null
                                          : const Icon(Icons.branding_watermark, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      brandModel.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
