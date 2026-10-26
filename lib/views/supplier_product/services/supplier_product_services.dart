import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/product/model/product_preview.dart';

class SupplierProductServices {
  Future<List<BrandModel>> getBrands() async {
    var url = AppNetWork.getBaseUrl("full/brands");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      SharedPref.setKey(
        value: response.body,
        key: SharedConsts.brands,
      );
      List<BrandModel> brands = [];
      for (var element in json["data"]) {
        brands.add(BrandModel.fromJson(element));
      }
      return brands;
    } else {
      return [];
    }
  }

  Future<int> addProduct({
    required String unit,
    required String basePrice,
    required String price,
    required String name,
    required String description,
    required int categoryId,
    required int brandId,
    required String material,
    required String discount,
  }) async {
    var url = AppNetWork.getBaseUrl("products");
    var body = jsonEncode({
      "unit": unit,
      "base_price": basePrice,
      "price": price,
      "shipping_status": true,
      "name": name,
      "description": description,
      "category_id": categoryId,
      "brand_id": brandId,
      "supplier_id": SharedPref.getSupplierId(),
      "material": material,
      "discount": discount,
      "stock_count": 100,
    });

    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );

    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      return json["data"]["id"];
    } else {
      return 0;
    }
  }

  Future<List<ProductPreview>> getProdcuts() async {
    var url = AppNetWork.getBaseUrl(
      "supplier-products/${SharedPref.getSupplierId()}",
    );
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      SharedPref.setKey(
        value: response.body,
        key: SharedConsts.supplierProducts,
      );
      List<ProductPreview> products = [];
      for (var element in json["data"]) {
        products.add(ProductPreview.fromJson(element));
      }
      return products;
    } else {
      return [];
    }
  }

  Future addImage(
      {required int id, required String image, required String order}) async {
    var url = AppNetWork.getBaseUrl("product/$id/images");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({"is_main": "0", "order": order});
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.headers.addAll(AppNetWork.headerAuth()!);
    await request.send();
  }

  Future deleteProduct(int id) async {
    var url = AppNetWork.getBaseUrl("products/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future deleteImage(int id) async {
    var url = AppNetWork.getBaseUrl("images/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future setImage({
    required int productId,
    required int imageId,
  }) async {
    var url = AppNetWork.getBaseUrl("products/$productId/is-main/$imageId");
    await http.patch(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  //* size & color
  Future addSize({
    required int porductId,
    required String color,
    required String size,
    required String count,
  }) async {
    var url = AppNetWork.getBaseUrl("product/$porductId/details");
    var body = jsonEncode({
      "color": color,
      "size": size,
      "count": count,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future<List> getFullDetails(int id) async {
    var url = AppNetWork.getBaseUrl("product/$id/full-details");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json["data"];
    } else {
      return [];
    }
  }

  Future addColor({
    required int porductId,
    required String color,
    required String size,
    required String count,
  }) async {
    var url = AppNetWork.getBaseUrl("product/$porductId/details");
    var body = jsonEncode({
      "color": color,
      "size": size,
      "count": count,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future deleteColor(int id) async {
    var url = AppNetWork.getBaseUrl("details/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  //* Overview
  Future addNewOverview({
    required String description,
    required String header,
    required int productId,
  }) async {
    var url = AppNetWork.getBaseUrl("overviews");
    var body = jsonEncode({
      "description": description,
      "header": header,
      "items": [],
      "product_id": productId,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future addNewOption({
    required String value,
    required String name,
    required int productId,
    required int order,
  }) async {
    var url = AppNetWork.getBaseUrl("product/$productId/options");
    var body = jsonEncode({
      "value": value,
      "name": name,
      "order": order,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  //* edit product
  Future editProduct({
    required String unit,
    required String basePrice,
    required String price,
    required String name,
    required String description,
    required int categoryId,
    required int brandId,
    required String material,
    required String discount,
    required int id,
  }) async {
    var url = AppNetWork.getBaseUrl("products/$id");
    var body = jsonEncode({
      "unit": unit,
      "base_price": basePrice,
      "price": price,
      "shipping_status": true,
      "name": name,
      "description": description,
      "category_id": categoryId,
      "brand_id": brandId,
      // "supplier_id": SharedPref.getSupplierId(),
      "material": material,
      "discount": discount,
      "stock_count": 100,
    });

    await http.patch(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  //*
  Future addNewCategory({
    required String name,
    required String note,
  }) async {
    var url = AppNetWork.getBaseUrl("category/suggestion");
    var body = jsonEncode({
      "name": name,
      "note": note,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future addNewSubcategory({
    required String name,
    required String note,
    required int categoryId,
  }) async {
    var url = AppNetWork.getBaseUrl("category/suggestion");
    var body = jsonEncode({
      "name": name,
      "note": note,
      "category_id": categoryId,
    });
    await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }
}
