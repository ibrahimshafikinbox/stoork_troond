import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import '../../../../config/routes/app_routes.dart';
import '../../model/product_preview.dart';

class RelatedProductCard extends StatelessWidget {
  const RelatedProductCard({super.key, required this.product});
  final RelatedProduct product;

  @override
  Widget build(BuildContext context) {
    // String image =
    //     product.image == null ? AppAseets.placeholder : product.image!.path;
    String price = product.price;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productPreviewScreen,
          arguments: product.id,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: (product.image == null || product.image!.path.isEmpty)
                ? Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColor.cDBDBDB.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey, size: 40),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: product.image!.path,
                      height: 140,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 140,
                        color: AppColor.cDBDBDB.withOpacity(0.2),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.main),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 140,
                        color: AppColor.cDBDBDB.withOpacity(0.3),
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: AppColor.c121212,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            //* dec
                            Text(
                              product.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.c121212,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BuildFavBtn(
                        productId: product.id,
                        isFav: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //* rate
                      product.rating == null || product.rating == 0
                          ? const SizedBox()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (index) {
                                    final double rate = (product.rating ?? 0).toDouble();
                                    if (index < rate.floor()) {
                                      return const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFFFB800),
                                        size: 13,
                                      );
                                    } else if (index < rate && rate % 1 != 0) {
                                      return const Icon(
                                        Icons.star_half_rounded,
                                        color: Color(0xFFFFB800),
                                        size: 13,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFE2E8F0),
                                        size: 13,
                                      );
                                    }
                                  }),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),

                      //* price
                      Expanded(
                        child: Text(
                          "$price ${AppStrings.currecy}",
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.main,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     height: 40,
                  //     child: AddToCart(productId: product.id, count: 1),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
