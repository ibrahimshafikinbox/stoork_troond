import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/fav/controller/fav_controller.dart';
import 'package:troond/views/product/ui/product_card/product_card_3.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';

class FromYourFavorite extends StatelessWidget {
  const FromYourFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Consumer<FavController>(
      builder: (context, favController, child) {
        var result = favController.favProducts;
        if (result.isEmpty) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  local.fromYourFavorite,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: result.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return ProductCard3(
                    key: ValueKey(result[index].id),
                    product: result[index],
                    isFav: true,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
