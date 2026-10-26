import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/ads/models/ads_model.dart';
import 'package:troond/views/ads/ui/slider_widget.dart';
import 'package:troond/views/app_bar/app_bar_widget.dart';
import 'package:troond/views/home/model/home_model.dart';
import 'package:troond/views/home/services/home_services.dart';
import 'package:troond/views/home/ui/widgets/daily_best_sells.dart';
import 'package:troond/views/home/ui/widgets/categories_widget.dart';
import 'package:troond/views/home/ui/widgets/nev_categories.dart';
import 'package:troond/views/home/ui/widgets/popular_brands.dart';
import 'package:troond/views/home/ui/widgets/popular_products.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../categories/ui/parent_category_screen/explore_more_widget.dart';
import '../../categories/ui/parent_category_screen/shop_by_brand_widget.dart';
import '../../categories/ui/parent_category_screen/shop_by_categories_widget.dart';
import 'widgets/random_category_widget.dart';
import 'widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainController mainController = Provider.of<MainController>(context);
    return Scaffold(
      appBar: const CustomAppBar.home(),
      body: FutureBuilder<HomeModel?>(
        future: HomeServices().getHome(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            var cacheDate = SharedPref.getKey(key: SharedConsts.home);
            if (cacheDate != null) {
              try {
                var data = jsonDecode(cacheDate);
                HomeModel home = HomeModel.fromJson(data["data"]);
                return _buildHomeScrollView(mainController, home);
              } catch (_) {}
            }
            return const HomeShimmerLoading();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            var cacheDate = SharedPref.getKey(key: SharedConsts.home);
            if (cacheDate == null) {
              return const HomeShimmerLoading();
            } else {
              try {
                var data = jsonDecode(cacheDate);
                HomeModel home = HomeModel.fromJson(data["data"]);
                return _buildHomeScrollView(mainController, home);
              } catch (_) {
                return const HomeShimmerLoading();
              }
            }
          }

          return _buildHomeScrollView(mainController, snapshot.data!);
        },
      ),
    );
  }

  Widget _buildHomeScrollView(MainController mainController, HomeModel result) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        NavCategoroies(mainController: mainController),
        SliverToBoxAdapter(
          child: mainController.navCategoryActive == null
              ? Column(
                  children: [
                    SliderWidget(homeModel: result),
                    CategoriesWidget(homeModel: result),
                    DailyBestSellsWidget(homeModel: result),
                    PopularProductsWidget(homeModel: result),
                    PopularBrandsWidget(homeModel: result),
                    RandomCaregoryWidget(
                      homeModel: result,
                      mainController: mainController,
                      scrollController: _scrollController,
                    ),
                  ],
                )
              : NavCategoryView(
                  id: mainController.navCategoryActive!,
                  adsModels: result.slider.items,
                ),
        ),
      ],
    );
  }
}

class NavCategoryView extends StatelessWidget {
  const NavCategoryView({
    super.key,
    required this.id,
    required this.adsModels,
  });
  final int id;
  final List<AdsModel> adsModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* ads
        SaleWidget(adsModels: adsModels),

        //* Shop by Categories
        ShopByCategoriesWidget(categoryId: id),

        //* Shop By Brand
        ShopByBrandWidget(categoryId: id),

        //* Explore more
        ExploreMore(categoryId: id),
      ],
    );
  }
}
