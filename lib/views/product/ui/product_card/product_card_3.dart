import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../../config/routes/app_routes.dart';

class ProductCard3 extends StatelessWidget {
  const ProductCard3({
    super.key,
    required this.product,
    this.isFav = false,
  });
  final ProductPreview product;
  final bool isFav;

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

    return Container(
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPreviewScreen,
              arguments: product.id,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 115,
                    height: 115,
                    color: Colors.white,
                    child: isValidImage
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CachedNetworkImage(
                              imageUrl: imgPath,
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColor.main.withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: 28,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
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
                                    fontSize: 13.5,
                                    height: 1.25,
                                  ),
                                ),
                                if (product.description.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    product.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          BuildFavBtn(
                            productId: product.id,
                            isFav: isFav,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (product.rating != null && product.rating! > 0)
                            RateCard(product: product)
                          else
                            const SizedBox(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${product.price} ${AppStrings.currecy}",
                                  textAlign: TextAlign.end,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColor.main,
                                    fontSize: 14.5,
                                  ),
                                ),
                                if (basePriceVal != null &&
                                    basePriceVal > product.price)
                                  Text(
                                    "$basePriceVal ${AppStrings.currecy}",
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade500,
                                      fontSize: 11,
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
      ),
    );
  }
}
