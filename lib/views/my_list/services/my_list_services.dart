import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/my_list/model/my_list_model.dart';

class MyListServices {
  Future<List<MyListModel>> getAllLists() async {
    var url = AppNetWork.getBaseUrl("lists");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      await SharedPref.setKey(value: response.body, key: SharedConsts.myList);
      List<MyListModel> myLists = [];
      for (var element in result["data"]) {
        myLists.add(MyListModel.fromJson(element));
      }
      return myLists;
    } else {
      return [];
    }
  }

  Future<bool> addList(String name) async {
    var url = AppNetWork.getBaseUrl("lists");
    var body = jsonEncode({"name": name});
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future editList({
    required int id,
    required String name,
  }) async {
    var url = AppNetWork.getBaseUrl("lists/$id");
    var body = jsonEncode({"name": name});
    http.Response response = await http.put(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteList({required int id}) async {
    var url = AppNetWork.getBaseUrl("lists/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future addItem({required int id, required int productId}) async {
    var url = AppNetWork.getBaseUrl("list/$id/items");
    var body = jsonEncode({"product_id": productId});
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future removeItem(int id) async {
    var url = AppNetWork.getBaseUrl("items/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }
}
