import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/services/product_services.dart';

import '../model/brand_preview.dart';

class BrandServices {
  Future<List<BrandModel>> getAllBrnads() async {
    var url = AppNetWork.getBaseUrl("brands");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<BrandModel> barndsModel = [];
      for (var element in result["data"]) {
        barndsModel.add(BrandModel.fromJson(element));
      }
      return barndsModel;
    } else {
      return [];
    }
  }

  Future<List<BrandModel>> getHomeBrands() async {
    try {
      var url = AppNetWork.getBaseUrl("home_brand");
      http.Response response = await http.get(
        url,
        headers: AppNetWork.header,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List<BrandModel> brandsModel = [];
        var data = result["data"] ?? result["results"] ?? result;
        if (data is List) {
          for (var element in data) {
            brandsModel.add(BrandModel.fromJson(element));
          }
        }
        return brandsModel;
      }
    } catch (e) {
      debugPrint("⚠️ [BrandServices.getHomeBrands] Error: $e");
    }
    return [];
  }

  Future<BranPreview?> getSingleBrand(int id) async {
    try {
      var url = AppNetWork.getBaseUrl("brands/$id");
      http.Response response = await http.get(
        url,
        headers: AppNetWork.header,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result["data"];
        if (data == null) return null;

        if (data is Map<String, dynamic> && data.containsKey("brand") && data["brand"] != null) {
          return BranPreview.fromJson(data);
        } else {
          BrandModel brand = BrandModel.fromJson(data);
          // Fetch products and categories concurrently
          final parallelResults = await Future.wait([
            getProductsByBrand(id),
            getCategoryOnBrand(id),
          ]);
          List<ProductPreview> products = parallelResults[0] as List<ProductPreview>;
          List<CategoryModel> categories = parallelResults[1] as List<CategoryModel>;
          List<ProductPreview> mostSold = products.take(6).toList();

          return BranPreview(
            brand: brand,
            mostSold: mostSold,
            products: products,
            categries: categories,
          );
        }
      } else {
        debugPrint("⚠️ [BrandServices.getSingleBrand] Status: ${response.statusCode}");
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint("❌ [BrandServices.getSingleBrand] Exception: $e\n$stackTrace");
      return null;
    }
  }

  Future<List<ProductPreview>> getProductsByBrand(int id) async {
    var url = AppNetWork.getBaseUrl("brands/products/$id?per_page=120&page=1");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<ProductPreview> products = [];
      for (var element in result["results"]) {
        products.add(ProductPreview.fromJson(element));
      }
      return products;
    } else {
      return [];
    }
  }

  Future<List<CategoryModel>> getCategoryOnBrand(int id) async {
    var url = AppNetWork.getBaseUrl("brands/categories/$id?limit=10");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<CategoryModel> products = [];
      for (var element in result["data"]) {
        products.add(CategoryModel.fromJson(element));
      }
      return products;
    } else {
      return [];
    }
  }

  Future<PaginatedProductsResult> getPaginatedProductsByBrand(
    int brandId, {
    int page = 1,
    int perPage = 10,
  }) async {
    List<ProductPreview> products = [];
    int totalCount = 0;
    int lastPage = 1;

    try {
      var url = Uri.parse(
        "https://api.troond.com/v3/api/filter?perPage=$perPage&page=$page&brands[]=$brandId",
      );
      debugPrint("🔎 [BrandServices] Fetching v3 page $page for Brand ID: $brandId");
      http.Response response =
          await http.get(url, headers: AppNetWork.header).timeout(
                const Duration(seconds: 10),
              );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var listData = result["data"] ?? result["results"] ?? result["items"];

        if (result["total"] != null) {
          totalCount = int.tryParse(result["total"].toString()) ?? 0;
        } else if (result["meta"] != null && result["meta"]["total"] != null) {
          totalCount = int.tryParse(result["meta"]["total"].toString()) ?? 0;
        }

        if (result["last_page"] != null) {
          lastPage = int.tryParse(result["last_page"].toString()) ?? 1;
        } else if (result["meta"] != null && result["meta"]["last_page"] != null) {
          lastPage = int.tryParse(result["meta"]["last_page"].toString()) ?? 1;
        }

        if (listData is List) {
          for (var element in listData) {
            try {
              products.add(ProductPreview.fromJson(element));
            } catch (e) {
              debugPrint("❌ [BrandServices] Parsing error in page $page: $e");
            }
          }
        }
      }
    } catch (e) {
      debugPrint("⚠️ [BrandServices] Exception in v3 page $page for Brand $brandId: $e");
    }

    if (products.isEmpty && page == 1) {
      try {
        var v1Url = AppNetWork.getBaseUrl(
          "brands/products/$brandId?per_page=$perPage&page=$page",
        );
        http.Response response = await http.get(v1Url).timeout(
              const Duration(seconds: 10),
            );
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          var listData = result["results"] ?? result["data"] ?? result["items"];

          if (result["total"] != null) {
            totalCount = int.tryParse(result["total"].toString()) ?? 0;
          }

          if (listData is List) {
            for (var element in listData) {
              try {
                products.add(ProductPreview.fromJson(element));
              } catch (_) {}
            }
          }
        }
      } catch (e) {
        debugPrint("⚠️ [BrandServices] Exception in v1 page $page: $e");
      }
    }

    if (totalCount == 0 && products.isNotEmpty) {
      totalCount = products.length;
    }

    bool hasMore = page < lastPage || (products.length >= perPage && totalCount > (page * perPage));

    return PaginatedProductsResult(
      products: products,
      totalCount: totalCount,
      currentPage: page,
      lastPage: lastPage,
      hasMore: hasMore,
    );
  }
}
