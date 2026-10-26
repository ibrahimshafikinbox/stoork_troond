import 'dart:convert';

import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/filter/model/filter_model.dart';
import 'package:http/http.dart' as http;

class FilterServices {
  Future<FilterModel?> getFilter(
      {required String category, required String brand}) async {
    var url = AppNetWork.getBaseUrl("filter?category=$category&brand=$brand");
    http.Response response = await http.get(url, headers: AppNetWork.header);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      FilterModel filterModel = FilterModel.fromJson(result["data"]);
      return filterModel;
    } else {
      return null;
    }
  }

  Future<FilterModel?> filter() async {
    var url = AppNetWork.getBaseUrl("filter");
    http.Response response = await http.get(url, headers: AppNetWork.header);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      FilterModel filterModel = FilterModel.fromJson(result["data"]);
      return filterModel;
    } else {
      return null;
    }
  }

  Future getAllFilteredProducts({
    required int categoryId,
    required int brandId,
    required int minPrice,
    required int maxPrice,
    required List colors,
    required List sizes,
  }) async {
    var url = AppNetWork.getBaseUrl("filted?page=1&per_page=1");
    var body = jsonEncode({
      "category_id": categoryId,
      "brand_id": brandId,
      "min_price": minPrice,
      "max_price": maxPrice,
      "colors": colors,
      "sizes": sizes,
    });
    // sort methods :
    // high_to_low , low_to_high ,best_sellers ,rating
    // http.Response response = 
    await http.post(
      url,
      headers: AppNetWork.header,
      body: body,
    );

    // if (response.statusCode == 200) {
    //   var result = jsonDecode(response.body);
    // } else {
    //   var result = jsonDecode(response.body);
    //   print(result);
    // }
  }
}
