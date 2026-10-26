import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';

class NavCategory {
  final CategoryModel category;
  final List<SubCategory> subCategories;

  NavCategory({
    required this.category,
    required this.subCategories,
  });

  factory NavCategory.fromJson(Map<String, dynamic> json) => NavCategory(
        category: CategoryModel.fromJson(json["category"]),
        subCategories: List<SubCategory>.from(
            json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      );
}

class SubCategory {
  final CategoryModel category;
  final List<BrandModel> brands;

  SubCategory({
    required this.category,
    required this.brands,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        category: CategoryModel.fromJson(json["category"]),
        brands: List<BrandModel>.from(json["brands"].map((x) => x)),
      );
}
