import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:http/http.dart' as http;
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';

class FavServices {
  /// Stores mapping from productId -> productVariantId (for DELETE /favorites/{variant})
  static final Map<int, int> productToVariantId = {};

  /// Stores mapping from productId -> favoriteRecordId
  static final Map<int, int> productToFavId = {};

  Future<List<ProductPreview>> getFavList() async {
    var url = AppNetWork.getBaseUrl("favorites");
    try {
      http.Response response = await http.get(
        url,
        headers: AppNetWork.headerAuth(),
      ).timeout(const Duration(seconds: 8));

      if (kDebugMode) {
        print("❤️ [FavServices getFavList] Status: ${response.statusCode} | URL: $url");
      }

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (kDebugMode) {
          print("❤️ [FavServices getFavList] Response Body: ${response.body}");
        }

        await SharedPref.setKey(value: response.body, key: SharedConsts.fav);
        List<ProductPreview> favList = [];
        if (result["data"] is List) {
          for (var element in result["data"]) {
            try {
              _extractAndStoreIds(element);

              if (element["product"] != null) {
                favList.add(ProductPreview.fromJson(element["product"]));
              }
            } catch (e) {
              if (kDebugMode) print("❤️ [FavServices getFavList] Parse item error: $e");
            }
          }
        }

        if (kDebugMode) {
          print("❤️ [FavServices getFavList] Loaded ${favList.length} products | Variants: $productToVariantId | FavIDs: $productToFavId");
        }
        return favList;
      }
    } catch (e) {
      if (kDebugMode) print("❤️ [FavServices getFavList Exception]: $e");
    }
    return getLocalFav();
  }

  Future<List<ProductPreview>> getLocalFav() async {
    try {
      var cache = SharedPref.getKey(key: SharedConsts.fav);
      if (cache != null && cache.isNotEmpty) {
        var fav = jsonDecode(cache);
        List<ProductPreview> favList = [];
        if (fav["data"] is List) {
          for (var element in fav["data"]) {
            try {
              _extractAndStoreIds(element);

              if (element["product"] != null) {
                favList.add(ProductPreview.fromJson(element["product"]));
              }
            } catch (_) {}
          }
        }
        return favList;
      }
    } catch (_) {}
    return [];
  }

  void _extractAndStoreIds(dynamic element) {
    if (element is! Map) return;

    int? favId = element["id"] is num
        ? (element["id"] as num).toInt()
        : int.tryParse(element["id"]?.toString() ?? "");

    int? prodId = element["product"]?["id"] ?? element["product_id"];

    int? vId = element["product_variant_id"] is num
        ? (element["product_variant_id"] as num).toInt()
        : int.tryParse(element["product_variant_id"]?.toString() ?? "");

    vId ??= element["variant_id"] is num
        ? (element["variant_id"] as num).toInt()
        : int.tryParse(element["variant_id"]?.toString() ?? "");

    vId ??= element["product_variant"]?["id"] is num
        ? (element["product_variant"]["id"] as num).toInt()
        : int.tryParse(element["product_variant"]?["id"]?.toString() ?? "");

    vId ??= element["variant"]?["id"] is num
        ? (element["variant"]["id"] as num).toInt()
        : int.tryParse(element["variant"]?["id"]?.toString() ?? "");

    vId ??= element["product"]?["product_variant_id"] is num
        ? (element["product"]["product_variant_id"] as num).toInt()
        : int.tryParse(element["product"]?["product_variant_id"]?.toString() ?? "");

    vId ??= element["product"]?["current_variant"]?["id"] is num
        ? (element["product"]["current_variant"]["id"] as num).toInt()
        : int.tryParse(element["product"]?["current_variant"]?["id"]?.toString() ?? "");

    if (vId == null && element["product"]?["colors"] is List && (element["product"]["colors"] as List).isNotEmpty) {
      var c0 = element["product"]["colors"][0];
      vId = c0["id"] is num ? (c0["id"] as num).toInt() : int.tryParse(c0["id"]?.toString() ?? "");
    }

    if (vId == null && element["product"]?["variants"] is List && (element["product"]["variants"] as List).isNotEmpty) {
      var v0 = element["product"]["variants"][0];
      vId = v0["id"] is num ? (v0["id"] as num).toInt() : int.tryParse(v0["id"]?.toString() ?? "");
    }

    if (prodId != null) {
      if (favId != null) productToFavId[prodId] = favId;
      if (vId != null) productToVariantId[prodId] = vId;
    }
  }

  Future<int?> getVariantIdForProduct(int productId) async {
    if (productToVariantId.containsKey(productId) && productToVariantId[productId] != null) {
      return productToVariantId[productId];
    }
    try {
      var productUrl = AppNetWork.getBaseUrl("full/product/$productId");
      http.Response pRes = await http.get(productUrl, headers: AppNetWork.header).timeout(const Duration(seconds: 4));
      if (pRes.statusCode == 200) {
        var pJson = jsonDecode(pRes.body);
        var pData = pJson["data"] ?? pJson;
        int? vId;
        if (pData["colors"] is List && (pData["colors"] as List).isNotEmpty) {
          var c0 = pData["colors"][0];
          vId = c0["id"] is num ? (c0["id"] as num).toInt() : int.tryParse(c0["id"].toString());
        } else if (pData["variants"] is List && (pData["variants"] as List).isNotEmpty) {
          var v0 = pData["variants"][0];
          vId = v0["id"] is num ? (v0["id"] as num).toInt() : int.tryParse(v0["id"].toString());
        }
        if (vId != null) {
          productToVariantId[productId] = vId;
          return vId;
        }
      }
    } catch (e) {
      if (kDebugMode) print("⚠️ [FavServices] getVariantIdForProduct error: $e");
    }
    return null;
  }

  Future<bool> addToFav(int productId, {int? productVariantId}) async {
    int? finalVariantId = productVariantId ?? productToVariantId[productId];
    finalVariantId ??= await getVariantIdForProduct(productId);
    finalVariantId ??= productId;

    var url = AppNetWork.getBaseUrl("favorites");
    var body = jsonEncode({
      "product_id": productId,
      "product_variant_id": finalVariantId,
    });
    try {
      var headers = AppNetWork.headerAuth();
      if (kDebugMode) {
        print("❤️ [FavServices addToFav] Adding productId: $productId (variantId: $finalVariantId) to $url");
      }
      http.Response response = await http.post(
        url,
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print("❤️ [FavServices addToFav] Status: ${response.statusCode} | Body: ${response.body}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          var resJson = jsonDecode(response.body);
          var data = resJson["data"] ?? resJson;
          int? newFavId = data["id"] is num
              ? (data["id"] as num).toInt()
              : int.tryParse(data["id"]?.toString() ?? "");
          if (newFavId != null) {
            productToFavId[productId] = newFavId;
          }
          productToVariantId[productId] = finalVariantId;
        } catch (_) {}
        return true;
      }
    } catch (e) {
      if (kDebugMode) print("❤️ [FavServices addToFav Exception]: $e");
    }
    return false;
  }

  Future<bool> deleteFromFav(int productId, {int? variantId}) async {
    int? targetVariantId = variantId ?? productToVariantId[productId];
    targetVariantId ??= await getVariantIdForProduct(productId);

    // List of candidate IDs to try:
    // 1. targetVariantId (Laravel Route Model Binding expects ProductVariants ID)
    // 2. productId (if productId is the variant ID)
    // 3. favoriteRecordId (if route is /favorites/{id})
    List<int> candidateIds = [];
    if (targetVariantId != null) candidateIds.add(targetVariantId);
    if (!candidateIds.contains(productId)) candidateIds.add(productId);
    int? favId = productToFavId[productId];
    if (favId != null && !candidateIds.contains(favId)) candidateIds.add(favId);

    if (kDebugMode) {
      print("❤️ [FavServices deleteFromFav] 🗑️ Deleting productId: $productId | Target VariantId: $targetVariantId | Candidates: $candidateIds");
    }

    var headers = AppNetWork.headerAuth();
    var body = jsonEncode({
      "product_id": productId,
      if (targetVariantId != null) "product_variant_id": targetVariantId,
      if (favId != null) "favorite_id": favId,
      if (favId != null) "id": favId,
    });

    for (int cid in candidateIds) {
      try {
        var url = AppNetWork.getBaseUrl("favorites/$cid");
        if (kDebugMode) {
          print("❤️ [FavServices deleteFromFav] 📤 DELETE $url | Body: $body");
        }
        http.Response response = await http.delete(
          url,
          headers: headers,
          body: body,
        ).timeout(const Duration(seconds: 6));

        if (kDebugMode) {
          print("❤️ [FavServices deleteFromFav] 📥 DELETE $url -> Status: ${response.statusCode} | Body: ${response.body}");
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          productToVariantId.remove(productId);
          productToFavId.remove(productId);
          return true;
        }
      } catch (e) {
        if (kDebugMode) print("❤️ [FavServices deleteFromFav] Exception with id $cid: $e");
      }
    }

    productToVariantId.remove(productId);
    productToFavId.remove(productId);
    return false;
  }
}
