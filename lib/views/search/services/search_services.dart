import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/product/model/product_preview.dart';

class SearchServices {
  Future<List<ProductPreview>> getSearch(String name) async {
    String cleanQuery = name.trim();
    if (cleanQuery.isEmpty) return [];

    try {
      var url =
          AppNetWork.getBaseUrl("search?name=${Uri.encodeComponent(cleanQuery)}");
      http.Response response = await http.get(url, headers: AppNetWork.header);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        dynamic rawData = result["data"] ?? result["products"] ?? result;

        List targetList = [];
        if (rawData is List) {
          targetList = rawData;
        } else if (rawData is Map && rawData["data"] is List) {
          targetList = rawData["data"];
        }

        if (targetList.isEmpty) return [];

        // Extract product IDs from search results
        List<int> productIds = [];
        for (var element in targetList) {
          if (element is Map) {
            int pid = element["product_id"] ?? element["id"] ?? 0;
            if (pid > 0) {
              productIds.add(pid);
            }
          }
        }

        if (productIds.isEmpty) return [];

        // Fetch full product details in parallel to get images
        List<ProductPreview> products = await _fetchProductsInParallel(productIds);
        return products;
      }
    } catch (e) {
      debugPrint("Search API Error: $e");
    }
    return [];
  }

  /// Fetches full product details in parallel using the full/product/:id endpoint
  /// which includes images in colors[0].images
  Future<List<ProductPreview>> _fetchProductsInParallel(List<int> productIds) async {
    // Limit concurrent requests to avoid overwhelming the server
    const int batchSize = 5;
    List<ProductPreview> allProducts = [];

    for (int i = 0; i < productIds.length; i += batchSize) {
      int end = (i + batchSize > productIds.length) ? productIds.length : i + batchSize;
      List<int> batch = productIds.sublist(i, end);

      List<Future<ProductPreview?>> futures = batch.map((id) => _fetchSingleProduct(id)).toList();
      List<ProductPreview?> results = await Future.wait(futures);

      for (var product in results) {
        if (product != null) {
          allProducts.add(product);
        }
      }
    }

    return allProducts;
  }

  /// Fetches a single product's full details
  Future<ProductPreview?> _fetchSingleProduct(int productId) async {
    try {
      var url = AppNetWork.getBaseUrl("full/product/$productId");
      http.Response response = await http
          .get(url, headers: AppNetWork.header)
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = json["data"];
        if (data != null && data is Map<String, dynamic>) {
          return ProductPreview.fromJson(data);
        } else if (data != null && data is Map) {
          return ProductPreview.fromJson(Map<String, dynamic>.from(data));
        }
      }
    } catch (e) {
      debugPrint("Error fetching product $productId: $e");
    }
    return null;
  }
}
