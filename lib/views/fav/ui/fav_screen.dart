import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/fav/controller/fav_controller.dart';
import 'package:troond/views/product/ui/product_card/product_card_3.dart';
import 'package:troond/views/product/ui/product_grid/product_grid.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/widget/btn/view_toggle_btn.dart';
import '../../../config/app_local/app_local.dart';
import 'package:troond/views/app_bar/app_bar_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key, this.hasBackBtn = false});
  final bool hasBackBtn;

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavController>().loadFavs();
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar.title(
        title: local.favorite,
        hasLead: widget.hasBackBtn,
        actions: [
          ViewToggleBtn(
            isGridView: isGridView,
            onChanged: (val) {
              setState(() {
                isGridView = val;
              });
            },
          ),
        ],
      ),
      body: Consumer<FavController>(
        builder: (context, favController, child) {
          if (!favController.isInitialized &&
              favController.favProducts.isEmpty) {
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColor.main,
                ),
              ),
            );
          }

          var result = favController.favProducts;

          if (result.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColor.main.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 46,
                          color: AppColor.main,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      local.emptyFavoriteTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.c121212,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      local.emptyFavoriteSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.hasBackBtn) {
                          Navigator.pop(context);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.mainScreen,
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            local.exploreProducts,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColor.main,
            onRefresh: () => context.read<FavController>().loadFavs(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: isGridView
                  ? BuildProductGrid(productList: result, isFav: true)
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return ProductCard3(
                          key: ValueKey(result[index].id),
                          product: result[index],
                          isFav: true,
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
