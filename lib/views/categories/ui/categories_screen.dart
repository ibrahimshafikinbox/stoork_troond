import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/app_bar/app_bar_widget.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/views/categories/ui/widget/main_categories_card.dart';
import 'package:troond/views/categories/ui/widget/sub_categories_grid.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/widget/loading/shimmer_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;
  final Map<int, List<CategoryModel>> _subCategoriesMap = {};
  final Map<int, bool> _loadingSubCatMap = {};

  Future<void> _fetchSubCategories(int parentId) async {
    if (_loadingSubCatMap[parentId] == true) return;
    setState(() {
      _loadingSubCatMap[parentId] = true;
    });
    try {
      var children = await CategoriesServices().getCategoryId(parentId);
      if (mounted) {
        setState(() {
          _subCategoriesMap[parentId] = children;
          _loadingSubCatMap[parentId] = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _subCategoriesMap[parentId] = [];
          _loadingSubCatMap[parentId] = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar.title(
        title: local.categories,
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: CategoriesServices().getParentCategories(),
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(key: SharedConsts.parentCategories);
          List<CategoryModel> categoriesList = [];

          if (cache != null) {
            try {
              var data = jsonDecode(cache);
              for (var element in data["data"]) {
                categoriesList.add(CategoryModel.fromJson(element));
              }
            } catch (_) {}
          }

          List<CategoryModel> result =
              snapshot.hasData ? snapshot.data! : categoriesList;

          if (result.isEmpty && !snapshot.hasData) {
            return const CategoryGridShimmerLoading(itemCount: 6);
          }

          if (result.isEmpty) {
            return Center(
              child: Text(
                local.noCategoriesAvailable,
                style: const TextStyle(
                  color: AppColor.c717171,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          if (_selectedIndex >= result.length) {
            _selectedIndex = 0;
          }

          CategoryModel activeCategory = result[_selectedIndex];
          List<CategoryModel>? subcategories;

          if (activeCategory.children.isNotEmpty) {
            subcategories = activeCategory.children;
          } else if (_subCategoriesMap.containsKey(activeCategory.id)) {
            subcategories = _subCategoriesMap[activeCategory.id];
          } else {
            _fetchSubCategories(activeCategory.id);
          }

          bool isLoading = _loadingSubCatMap[activeCategory.id] == true;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainCategoriesCard(
                  categories: result,
                  selectedIndex: _selectedIndex,
                  onSelectCategory: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SubCategoriesGrid(
                  activeCategory: activeCategory,
                  subcategories: subcategories,
                  isLoading: isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
