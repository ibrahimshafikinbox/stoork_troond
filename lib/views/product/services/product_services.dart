import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';

class PorductServices {
  Future<ProductPreview?> getProduct(int id) async {
    var url = AppNetWork.getBaseUrl("full/product/$id");
    try {
      print(
          "🔎 [ProductServices] Fetching product details for ID: $id from $url");
      http.Response response =
          await http.get(url, headers: AppNetWork.header).timeout(
                const Duration(seconds: 10),
              );
      print(
          "📡 [ProductServices] Product ID $id details -> Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        await SharedPref.setKey(
          value: response.body,
          key: "${SharedConsts.product}$id",
        );
        var data = ProductPreview.fromJson(json["data"]);
        return data;
      }
    } catch (e) {
      print("❌ [ProductServices] Error fetching product ID $id details: $e");
    }
    return null;
  }

  Future<List<ProductPreview>> getProductsByCategoryId(int categoryId) async {
    List<ProductPreview> products = [];

    // 1. المحاولة الأولى: طلب منتجات القسم عبر v3 Filter Endpoint (مطابقة الموقع)
    try {
      var url = Uri.parse(
        "https://api.troond.com/v3/api/filter?perPage=120&page=1&categories[]=$categoryId",
      );
      print(
          "🔎 [ProductServices] Fetching v3 filter products for Category ID: $categoryId from Endpoint: $url");
      http.Response response =
          await http.get(url, headers: AppNetWork.header).timeout(
                const Duration(seconds: 10),
              );
      print(
          "📡 [ProductServices] Category ID $categoryId -> HTTP Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var listData = result["data"] ?? result["results"] ?? result["items"];
        if (listData is List) {
          print(
              "📦 [ProductServices] Category ID $categoryId -> v3 Filter returned ${listData.length} raw products");
          for (var element in listData) {
            try {
              products.add(ProductPreview.fromJson(element));
            } catch (e) {
              print(
                  "❌ [ProductServices] Error parsing product JSON in Category $categoryId: $e");
            }
          }
        }
      }
    } catch (e) {
      print(
          "⚠️ [ProductServices] Exception fetching v3 products for Category $categoryId: $e");
    }

    // 2. المحاولة الثانية: إذا عاد السيرفر بـ قائمة فارغة، جلب المنتجات كـ Subcategory في v3
    if (products.isEmpty) {
      try {
        var subUrl = Uri.parse(
          "https://api.troond.com/v3/api/filter?perPage=120&page=1&subcategories[]=$categoryId",
        );
        print(
            "🔄 [ProductServices] Category ID $categoryId returned 0 via categories[]. Trying subcategories[] fallback: $subUrl");
        http.Response response =
            await http.get(subUrl, headers: AppNetWork.header).timeout(
                  const Duration(seconds: 10),
                );
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          var listData = result["data"] ?? result["results"] ?? result["items"];
          if (listData is List) {
            print(
                "📦 [ProductServices] Category ID $categoryId -> v3 Subcategory returned ${listData.length} raw products");
            for (var element in listData) {
              try {
                products.add(ProductPreview.fromJson(element));
              } catch (e) {
                print(
                    "❌ [ProductServices] Error parsing product in subcategory fallback: $e");
              }
            }
          }
        }
      } catch (e) {
        print(
            "⚠️ [ProductServices] Exception in subcategory fallback for Category $categoryId: $e");
      }
    }

    // 3. المحاولة الثالثة: إذا لم يرجع v3 شيئاً، جلب المنتجات من v1 Endpoint
    if (products.isEmpty) {
      print(
          "🔄 [ProductServices] Trying v1 categories/products fallback for Category $categoryId...");
      try {
        var v1Url = AppNetWork.getBaseUrl(
            "categories/products/$categoryId?per_page=120&page=1");
        http.Response response =
            await http.get(v1Url, headers: AppNetWork.header).timeout(
                  const Duration(seconds: 10),
                );
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          var listData = result["data"] ?? result["results"] ?? result["items"];
          if (listData is List) {
            for (var element in listData) {
              try {
                products.add(ProductPreview.fromJson(element));
              } catch (e) {
                print(
                    "❌ [ProductServices] Error parsing product in v1 fallback: $e");
              }
            }
          }
        }
      } catch (e) {
        print(
            "⚠️ [ProductServices] Exception in v1 fallback for Category $categoryId: $e");
      }
    }

    print(
        "📊 [ProductServices] Final parsed products count for Category $categoryId: ${products.length}");
    return products;
  }

  Future<PaginatedProductsResult> getPaginatedProducts({
    int? categoryId,
    int page = 1,
    int perPage = 20,
  }) async {
    List<ProductPreview> products = [];
    int totalCount = 0;
    int lastPage = 1;

    // 1. v3 Filter Endpoint
    try {
      String urlStr = "https://api.troond.com/v3/api/filter?perPage=$perPage&page=$page";
      if (categoryId != null) {
        urlStr += "&categories[]=$categoryId";
      }
      var url = Uri.parse(urlStr);
      print("🔎 [ProductServices] Fetching v3 page $page (Category: $categoryId) from $url");
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
              print("❌ [ProductServices] Parsing error in page $page: $e");
            }
          }
        }
      }
    } catch (e) {
      print("⚠️ [ProductServices] Exception in v3 page $page: $e");
    }

    // 2. Subcategory Fallback (page 1)
    if (categoryId != null && products.isEmpty && page == 1) {
      try {
        var subUrl = Uri.parse(
          "https://api.troond.com/v3/api/filter?perPage=$perPage&page=$page&subcategories[]=$categoryId",
        );
        http.Response response =
            await http.get(subUrl, headers: AppNetWork.header).timeout(
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
        print("⚠️ [ProductServices] Exception in subcategory page $page: $e");
      }
    }

    // 3. v1 Fallback (page 1)
    if (categoryId != null && products.isEmpty && page == 1) {
      try {
        var v1Url = AppNetWork.getBaseUrl(
            "categories/products/$categoryId?per_page=$perPage&page=$page");
        http.Response response =
            await http.get(v1Url, headers: AppNetWork.header).timeout(
                  const Duration(seconds: 10),
                );
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          var listData = result["data"] ?? result["results"] ?? result["items"];

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
        print("⚠️ [ProductServices] Exception in v1 page $page: $e");
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

  Future<PaginatedProductsResult> getPaginatedProductsByCategoryId(
    int categoryId, {
    int page = 1,
    int perPage = 20,
  }) {
    return getPaginatedProducts(
      categoryId: categoryId,
      page: page,
      perPage: perPage,
    );
  }
}

class PaginatedProductsResult {
  final List<ProductPreview> products;
  final int totalCount;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  PaginatedProductsResult({
    required this.products,
    required this.totalCount,
    required this.currentPage,
    required this.lastPage,
    required this.hasMore,
  });
}
