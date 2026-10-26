import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/widget/btn/more_btn.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../product/model/product_preview.dart';
import '../../../product/ui/product_card/small_product_card.dart';
import '../../model/home_model.dart';

class DailyBestSellsWidget extends StatelessWidget {
  const DailyBestSellsWidget({
    super.key,
    required this.homeModel,
  });
  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    List<ProductPreview> productList = homeModel.mostSold;
    var local = MyLocalizations.getLocal(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding8,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                local.dailyBestSells,
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              MoreBtn(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productsListScreen2,
                    arguments: {
                      'title': local.dailyBestSells,
                      'products': productList,
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // const Image(
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        //   image: AssetImage(
        //     "${AppAssets.imagesPath}Daily_Best_Sells1.png",
        //   ),
        // ),
        const SizedBox(height: 5),
        productList.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: SizedBox(
                  height: 285,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
              ),
        SizedBox(height: productList.isEmpty ? 0 : 10),
        // const Image(
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   image: AssetImage("${AppAssets.imagesPath}shop_now.png"),
        // ),
      ],
    );
  }
}
