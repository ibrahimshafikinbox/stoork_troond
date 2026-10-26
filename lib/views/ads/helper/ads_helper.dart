import 'package:flutter/widgets.dart';
import 'package:troond/views/product/services/product_services.dart';

import '../../../config/routes/app_routes.dart';

class AdsHelper {
  void onTapAds({
    required int? productId,
    required BuildContext context,
    required int? categoryId,
    required int? brandId,
  }) async {
    if (productId != null) {
      Navigator.of(context).pushNamed(
        AppRoutes.productPreviewScreen,
        arguments: productId,
      );
    } else if (categoryId != null) {
      Navigator.of(context).pushNamed(
        AppRoutes.productsListScreen,
        arguments: PorductServices().getProductsByCategoryId(
          categoryId,
        ),
      );
    } else if (brandId != null) {
      Navigator.of(context).pushNamed(
        AppRoutes.brandScreen,
        arguments: brandId,
      );
    }
  }
}
