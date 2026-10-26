import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../../config/routes/app_routes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.isFav = false,
    this.imageHeight = 160,
  });
  final ProductPreview product;
  final bool isFav;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
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

    int? basePriceVal;
    if (product.basePrice.isNotEmpty) {
      basePriceVal =
          int.tryParse(product.basePrice.replaceAll(RegExp(r'[^0-9]'), ''));
    }

    bool hasDiscount = (basePriceVal != null && basePriceVal > product.price) ||
        (product.discount.isNotEmpty && product.discount != "0");

    String discountText = "";
    if (product.discount.isNotEmpty && product.discount != "0") {
      discountText = product.discount.contains('%')
          ? product.discount
          : "-${product.discount}%";
    } else if (basePriceVal != null && basePriceVal > product.price) {
      int perc =
          (((basePriceVal - product.price) / basePriceVal) * 100).round();
      if (perc > 0) discountText = "-$perc%";
    }

    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8ECEF),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPreviewScreen,
              arguments: product.id,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              //* Image stack with fav and discount badge
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: isValidImage
                          ? Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CachedNetworkImage(
                                imageUrl: imgPath,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
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
                  if (hasDiscount && discountText.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.main,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          discountText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
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

              //* Details / Info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //* Rating
                        if (product.rating != null && product.rating! > 0)
                          RateCard(product: product)
                        else
                          const SizedBox(),

                        //* Price formatting
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${product.price} ${AppStrings.currecy}",
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.main,
                                  fontSize: 13.5,
                                ),
                              ),
                              if (basePriceVal != null &&
                                  basePriceVal > product.price)
                                Text(
                                  "$basePriceVal ${AppStrings.currecy}",
                                  textAlign: TextAlign.right,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                    fontSize: 10.5,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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
