import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../data/shared_pref/shared_pref.dart';

class NavCategoroies extends StatelessWidget {
  const NavCategoroies({super.key, required this.mainController});
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      toolbarHeight: 35,
      leading: const SizedBox(),
      flexibleSpace: FutureBuilder<List>(
        future: CategoriesServices().getNavCategory(),
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(key: "getNavCategory");
          if (cache == null && !snapshot.hasData) {
            return const NavCategoryShimmerLoading();
          } else {
            if (!snapshot.hasData) {
              if (cache == null) return const NavCategoryShimmerLoading();
              var result = jsonDecode(cache);
              List navCategory = result["data"];
              return NavCategoryBody(
                mainController: mainController,
                result: navCategory,
              );
            } else {
              var result = snapshot.data!;
              return NavCategoryBody(
                mainController: mainController,
                result: result,
              );
            }
          }
        },
      ),
    );
  }
}

class NavCategoryBody extends StatelessWidget {
  const NavCategoryBody({
    super.key,
    required this.mainController,
    required this.result,
  });

  final MainController mainController;
  final List result;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              mainController.chooseNavCategory(null);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: AppColor.cDBDBDB),
              ),
              color: mainController.navCategoryActive == null
                  ? AppColor.main
                  : AppColor.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                child: Center(
                  child: Text(
                    local.all,
                    style: TextStyle(
                      color: mainController.navCategoryActive == null
                          ? AppColor.white
                          : AppColor.c717171,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = result[index];
                int id = item["category"]["id"];
                return InkWell(
                  onTap: () {
                    mainController.chooseNavCategory(
                      item["category"]["id"],
                    );
                  },
                  child: Card(
                    color: mainController.navCategoryActive == id
                        ? AppColor.main
                        : AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: AppColor.cDBDBDB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      child: Center(
                        child: Text(
                          item["category"]["name"],
                          style: TextStyle(
                            color: mainController.navCategoryActive == id
                                ? AppColor.white
                                : AppColor.c717171,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
