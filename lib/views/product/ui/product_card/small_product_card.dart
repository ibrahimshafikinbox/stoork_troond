import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/product/model/product_preview.dart';
import '../../../../config/routes/app_routes.dart';

import 'package:troond/widget/rate/rate_card.dart';

class SmallProductCard extends StatelessWidget {
  const SmallProductCard({
    super.key,
    required this.product,
    this.isFav = false,
  });
  final ProductPreview product;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    String mainImage = "";
    if (product.images.isNotEmpty) {
      for (var element in product.images) {
        if (element.isMain == 1 && element.path.trim().isNotEmpty) {
          mainImage = element.path.trim();
          break;
        }
      }
      if (mainImage.isEmpty) {
        for (var element in product.images) {
          if (element.path.trim().isNotEmpty) {
            mainImage = element.path.trim();
            break;
          }
        }
      }
    }

    if (mainImage.isNotEmpty &&
        !mainImage.startsWith("http://") &&
        !mainImage.startsWith("https://")) {
      if (mainImage.startsWith("/")) {
        mainImage = "https://api.troond.com$mainImage";
      } else {
        mainImage = "https://api.troond.com/$mainImage";
      }
    }

    bool isValidImage = mainImage.isNotEmpty &&
        (mainImage.startsWith("http://") || mainImage.startsWith("https://"));

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 1.5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //* image
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.productPreviewScreen,
                      arguments: product.id,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: isValidImage
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CachedNetworkImage(
                                imageUrl: mainImage,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColor.main,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: BuildFavBtn(productId: product.id, isFav: isFav),
                ),
              ],
            ),

            //* info
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productPreviewScreen,
                  arguments: product.id,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.25,
                      ),
                    ),
                    if (product.description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                    if (product.rating != null && product.rating! > 0) ...[
                      const SizedBox(height: 4),
                      RateCard(product: product, starSize: 11),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      "${product.price} ${AppStrings.currecy}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColor.main,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
