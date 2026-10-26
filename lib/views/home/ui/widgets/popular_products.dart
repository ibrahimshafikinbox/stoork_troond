import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/home/model/home_model.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_card/small_product_card.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../widget/btn/more_btn.dart';

class PopularProductsWidget extends StatelessWidget {
  const PopularProductsWidget({super.key, required this.homeModel});
  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    List<ProductPreview> productList = homeModel.popluarProducts;
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                local.popularProducts,
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              MoreBtn(onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productsListScreen2,
                  arguments: {
                    'title': local.popularProducts,
                    'products': productList,
                  },
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          productList.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 285,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 175,
                        child: SmallProductCard(product: productList[index]),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
