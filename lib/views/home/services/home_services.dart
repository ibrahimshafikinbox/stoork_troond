import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/home/model/home_group_model.dart';
import 'package:troond/views/home/model/home_model.dart';

class HomeServices {
  Future<HomeModel?> getHome() async {
    var url = Uri.parse("${AppNetWork.baseUrl}home");
    http.Response response = await http.get(url, headers: AppNetWork.header);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      await SharedPref.setKey(value: response.body, key: SharedConsts.home);
      if (result["success"] == true) {
        HomeModel homeModel = HomeModel.fromJson(result["data"]);
        return homeModel;
      }
    } else {
      return null;
    }
    return null;
  }

  Future<PaginatedHomeGroupResult> getHomeGroups({
    int page = 1,
    int perPage = 9,
  }) async {
    try {
      var url = Uri.parse("${AppNetWork.baseUrl}home-group?page=$page&per_page=$perPage");
      http.Response response = await http.get(url, headers: AppNetWork.header);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List<HomeGroupModel> list = [];
        var data = result["data"] ?? result["results"] ?? [];
        int total = result["total"] != null ? int.tryParse(result["total"].toString()) ?? 0 : 0;
        int currentPage = result["current_page"] != null ? int.tryParse(result["current_page"].toString()) ?? page : page;
        int lastPage = result["last_page"] != null ? int.tryParse(result["last_page"].toString()) ?? 1 : 1;

        if (data is List) {
          for (var item in data) {
            list.add(HomeGroupModel.fromJson(item));
          }
        }

        bool hasMore = currentPage < lastPage || (list.length >= perPage && total > (currentPage * perPage));

        return PaginatedHomeGroupResult(
          items: list,
          totalCount: total,
          currentPage: currentPage,
          lastPage: lastPage,
          hasMore: hasMore,
        );
      }
    } catch (e) {
      debugPrint("⚠️ [HomeServices.getHomeGroups] Exception: $e");
    }
    return PaginatedHomeGroupResult(
      items: [],
      totalCount: 0,
      currentPage: page,
      lastPage: 1,
      hasMore: false,
    );
  }
}

