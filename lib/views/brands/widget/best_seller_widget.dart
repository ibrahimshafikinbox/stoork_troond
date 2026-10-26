import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/routes/app_routes.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({
    super.key,
    required this.product,
    this.isFav = false,
  });
  final ProductPreview product;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    String imgPath = "";
    if (product.images.isNotEmpty) {
      for (var element in product.images) {
        if (element.isMain == 1 && element.path.trim().isNotEmpty) {
          imgPath = element.path.trim();
          break;
        }
      }
      if (imgPath.isEmpty) {
        for (var element in product.images) {
          if (element.path.trim().isNotEmpty) {
            imgPath = element.path.trim();
            break;
          }
        }
      }
    }

    if (imgPath.isNotEmpty &&
        !imgPath.startsWith("http://") &&
        !imgPath.startsWith("https://")) {
      if (imgPath.startsWith("/")) {
        imgPath = "https://api.troond.com$imgPath";
      } else {
        imgPath = "https://api.troond.com/$imgPath";
      }
    }

    bool isValidImage = imgPath.isNotEmpty &&
        (imgPath.startsWith("http://") || imgPath.startsWith("https://"));

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 8),
      child: Card(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPreviewScreen,
              arguments: product.id,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //* Image section with shimmer loading & ribbon
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.white,
                    child: isValidImage
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CachedNetworkImage(
                              imageUrl: imgPath,
                              fit: BoxFit.contain,
                              placeholder: (_, __) => const ShimmerWidget.rectangular(
                                height: 120,
                                width: double.infinity,
                                shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              errorWidget: (_, __, ___) => const Icon(
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
                  // Fav Button
                  Align(
                    alignment: Alignment.topRight,
                    child: BuildFavBtn(productId: product.id, isFav: isFav),
                  ),
                  // Floating Best Seller Tag
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.c40CB02,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1.5),
                          ),
                        ],
                      ),
                      child: Text(
                        local.bestSeller,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //* Product Details Info
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                          fontSize: 10,
                        ),
                      ),
                    ],
                    if (product.rating != null && product.rating! > 0) ...[
                      const SizedBox(height: 4),
                      RateCard(product: product),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      "${product.price} ${AppStrings.currecy}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColor.main,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

