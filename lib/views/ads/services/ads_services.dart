import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/ads/models/ads_model.dart';

class AdsServices {
  Future<List<AdsModel>> getAdsByCategoryId(int id) async {
    var url = AppNetWork.getBaseUrl(
        "advertises?per_page=1&page=1&is_home=false&category_id=$id&our_offer=false");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<AdsModel> adsModels = [];
      for (var element in data["data"]["items"]) {
        adsModels.add(AdsModel.fromJson(element));
      }
      return adsModels;
    } else {
      return [];
    }
  }

  Future<List<AdsModel>> getAdsByBrandId(int id) async {
    var url = AppNetWork.getBaseUrl(
        "advertises?per_page=1&page=1&is_home=false&brand_id=$id&our_offer=false");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<AdsModel> adsModels = [];
      for (var element in data["data"]["items"]) {
        adsModels.add(AdsModel.fromJson(element));
      }
      return adsModels;
    } else {
      return [];
    }
  }
}
