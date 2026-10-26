import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/cart/model/product_cart.dart';

class CartServices {
  Future<bool> addToCart({
    required int id,
    required int? detailId,
    required int count,
    int? productVariantId,
    int? sizeId,
  }) async {
    try {
      var url = AppNetWork.baseUrl.endsWith("/") 
          ? Uri.parse("${AppNetWork.baseUrl}carts")
          : AppNetWork.getBaseUrl("carts");
      var headers = AppNetWork.headerAuth();

      int finalProductId = id;
      int? finalVariantId = productVariantId ?? detailId;
      int? finalSizeId = sizeId;

      // إذا لم يتوفر رقم المتغير (product_variant_id) أو رقم المقاس (size_id)، نجلبه أوتوماتيكياً من تفاصيل المنتج
      if (finalVariantId == null || finalSizeId == null) {
        try {
          var productUrl = AppNetWork.getBaseUrl("full/product/$id");
          http.Response pRes = await http.get(productUrl, headers: AppNetWork.header).timeout(const Duration(seconds: 5));
          if (pRes.statusCode == 200) {
            var pJson = jsonDecode(pRes.body);
            var pData = pJson["data"] ?? pJson;

            if (pData["colors"] is List && (pData["colors"] as List).isNotEmpty) {
              var c0 = pData["colors"][0];
              finalVariantId ??= c0["id"] is num ? (c0["id"] as num).toInt() : int.tryParse(c0["id"].toString());
              if (c0["sizes"] is List && (c0["sizes"] as List).isNotEmpty) {
                finalSizeId ??= c0["sizes"][0]["id"] is num ? (c0["sizes"][0]["id"] as num).toInt() : int.tryParse(c0["sizes"][0]["id"].toString());
              } else if (c0["price"] is List && (c0["price"] as List).isNotEmpty) {
                finalSizeId ??= c0["price"][0]["size_id"] is num ? (c0["price"][0]["size_id"] as num).toInt() : int.tryParse(c0["price"][0]["size_id"].toString());
              }
            }
          }
        } catch (e) {
          print("⚠️ [CartServices] Auto-resolve variant/size notice: $e");
        }
      }

      Map<String, dynamic> itemMap = {
        "product_id": finalProductId,
        if (finalVariantId != null) "product_variant_id": finalVariantId,
        if (finalSizeId != null) "size_id": finalSizeId,
        if (detailId != null) "product_detail_id": detailId,
        "count": count,
      };

      var body = jsonEncode({
        "items": [itemMap],
        "product_id": finalProductId,
        if (finalVariantId != null) "product_variant_id": finalVariantId,
        if (finalSizeId != null) "size_id": finalSizeId,
        if (detailId != null) "product_detail_id": detailId,
        "count": count,
      });

      print("\n=======================================================");
      print("🛒 [CartServices] 📤 طلب إضافة منتج إلى السلة في الباك إند");
      print("   📍 URL: $url");
      print("   🔑 Authorization Token/Headers: $headers");
      print("   📦 Payload Body: $body");

      http.Response response = await http
          .post(
            url,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 10));

      print(
          "📡 [CartServices] 📥 استجابة السيرفر status: ${response.statusCode}");
      print("   📄 Full Response Body: ${response.body}");
      print("=======================================================\n");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else if (response.statusCode == 401) {
        print(
            "🚨 [CartServices] 401 Unauthenticated: التوكن غير صالح أو انتهت صلاحية الجلسة!");
      }
    } catch (e) {
      print("❌ [CartServices] Exception in addToCart: $e");
    }
    return false;
  }

  Future<List<ProductCart>> getCart() async {
    try {
      var url = AppNetWork.getBaseUrl("carts");
      var headers = AppNetWork.headerAuth();

      print("\n=======================================================");
      print("🛒 [CartServices] 📤 طلب جلب منتجات السلة من الباك إند");
      print("   📍 URL: $url");
      print("   🔑 Authorization Token/Headers: $headers");

      http.Response response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print(
          "📡 [CartServices] 📥 استجابة السيرفر status: ${response.statusCode}");
      print("   📄 Full Response Body: ${response.body}");
      print("=======================================================\n");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        await SharedPref.setKey(value: response.body, key: SharedConsts.cart);
        List<ProductCart> productsCart = [];
        var listData = result["data"] ?? result["results"] ?? result["items"];
        if (listData is List) {
          for (var element in listData) {
            try {
              productsCart.add(ProductCart.fromJson(element));
            } catch (e) {
              print("❌ [CartServices] Error parsing cart item JSON: $e");
              print("   Element payload sample: $element");
            }
          }
        }
        productsCart.removeWhere((element) => element.product == null);
        print(
            "📦 [CartServices] إجمالي منتجات السلة المكتشفة: ${productsCart.length}");
        return productsCart;
      }
    } catch (e) {
      print("❌ [CartServices] Exception in getCart: $e");
    }
    return [];
  }

  Future updateCount({required int count, required int cardId}) async {
    try {
      var url = AppNetWork.getBaseUrl("carts/$cardId");
      var headers = AppNetWork.headerAuth();
      var body = jsonEncode({"count": count});

      print("\n=======================================================");
      print("🛒 [CartServices] 📤 تحديث كمية المنتج رقم $cardId إلى $count");
      print("   📍 URL: $url");
      print("   🔑 Authorization Token/Headers: $headers");
      print("   📦 Payload Body: $body");

      http.Response response = await http
          .put(
            url,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 10));

      print(
          "📡 [CartServices] 📥 استجابة السيرفر status: ${response.statusCode}");
      print("   📄 Full Response Body: ${response.body}");
      print("=======================================================\n");
    } catch (e) {
      print("❌ [CartServices] Exception in updateCount: $e");
    }
  }

  Future delete({required int cardId}) async {
    try {
      var url = AppNetWork.getBaseUrl("carts/$cardId");
      var headers = AppNetWork.headerAuth();

      print("\n=======================================================");
      print("🛒 [CartServices] 📤 حذف عنصر السلة رقم $cardId");
      print("   📍 URL: $url");
      print("   🔑 Authorization Token/Headers: $headers");

      http.Response response = await http
          .delete(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      print(
          "📡 [CartServices] 📥 استجابة السيرفر status: ${response.statusCode}");
      print("   📄 Full Response Body: ${response.body}");
      print("=======================================================\n");
    } catch (e) {
      print("❌ [CartServices] Exception in delete: $e");
    }
  }
}
