import 'package:flutter/material.dart';
import 'package:troond/views/ads/models/ads_model.dart';
import 'package:troond/views/ads/services/ads_services.dart';
import 'package:troond/views/categories/ui/parent_category_screen/explore_more_widget.dart';
import 'package:troond/views/categories/ui/parent_category_screen/shop_by_brand_widget.dart';
import 'package:troond/views/categories/ui/parent_category_screen/shop_by_categories_widget.dart';
import '../../../app_bar/app_bar_widget.dart';
import '../../../home/ui/widgets/sale_widget.dart';

class ViewParnetCategory extends StatelessWidget {
  const ViewParnetCategory({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.search(hasLead: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* ads
            FutureBuilder<List<AdsModel>>(
              future: AdsServices().getAdsByCategoryId(id),
              builder: (context, snapshot) {
                List<AdsModel> result = snapshot.hasData ? snapshot.data! : [];
                return SaleWidget(adsModels: result);
              },
            ),

            //* Shop by Categories
            ShopByCategoriesWidget(categoryId: id),

            //* Shop By Brand
            ShopByBrandWidget(categoryId: id),

            //* Explore more
            ExploreMore(categoryId: id),
          ],
        ),
      ),
    );
  }
}
