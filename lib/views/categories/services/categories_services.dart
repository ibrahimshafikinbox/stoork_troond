import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import '../../../config/network/app_network.dart';
import '../../home/model/category_model.dart';
import '../../product/services/product_services.dart';

class CategoriesServices {
  Future<List<CategoryModel>> getCategories() async {
    var url = AppNetWork.getBaseUrl("categories");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      await SharedPref.setKey(
        value: response.body,
        key: SharedConsts.categories,
      );
      List<CategoryModel> categoriesList = [];
      for (var element in result["data"]) {
        categoriesList.add(CategoryModel.fromJson(element));
      }
      return categoriesList;
    } else {
      return [];
    }
  }

  Future<List<CategoryModel>> getCategoryId(int id) async {
    var url = AppNetWork.getBaseUrl("categories/$id");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      CategoryModel categoriesList = CategoryModel.fromJson(result["data"]);
      return categoriesList.children;
    } else {
      return [];
    }
  }

  Future<List<CategoryModel>> getParentCategories() async {
    var url = AppNetWork.getBaseUrl("parent/categories");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await SharedPref.setKey(
        value: response.body,
        key: SharedConsts.parentCategories,
      );
      List<CategoryModel> categoriesList = [];
      for (var element in json["data"]) {
        categoriesList.add(CategoryModel.fromJson(element));
      }
      return categoriesList;
    } else {
      return [];
    }
  }

  Future<List<BrandModel>> getShopByBrand(int categoryId) async {
    var url = AppNetWork.getBaseUrl("categories/brands/$categoryId?limit=100");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<BrandModel> brandList = [];
      for (var element in result["data"]) {
        brandList.add(BrandModel.fromJson(element));
      }
      return brandList;
    } else {
      return [];
    }
  }

  Future<List> getNavCategory() async {
    var url = AppNetWork.getBaseUrl("navbar/cateogries");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      await SharedPref.setKey(value: response.body, key: "getNavCategory");
      var result = jsonDecode(response.body);
      List navCategory = result["data"];
      return navCategory;
    } else {
      return [];
    }
  }

  Future<void> printDetailedCategoryReport() async {
    print("\n=======================================================");
    print("📋 [DEBUG REPORT] بدء فحص الأقسام والمنتجات التفصيلي");
    print("=======================================================");
    try {
      List<CategoryModel> parents = await getParentCategories();
      print("إجمالي الأقسام الرئيسية: ${parents.length}");
      for (var parent in parents) {
        var products = await PorductServices().getProductsByCategoryId(parent.id);
        print("📂 قسم رئيسي [ID: ${parent.id}] -> Name: \"${parent.name}\" | عدد المنتجات: ${products.length}");
        if (parent.children.isNotEmpty) {
          for (var child in parent.children) {
            var childProducts = await PorductServices().getProductsByCategoryId(child.id);
            print("   └── 📄 قسم فرعي [ID: ${child.id}] -> Name: \"${child.name}\" | عدد المنتجات: ${childProducts.length}");
          }
        }
      }
    } catch (e) {
      print("❌ [DEBUG REPORT] خطأ أثناء إنشاء التقرير: $e");
    }
    print("=======================================================\n");
  }
}
