import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/address/model/address_model.dart';
import 'package:troond/views/address/model/cities_model.dart';

class AddressServices {
  Future<List<AddressModel>> getAddress() async {
    var url = AppNetWork.getBaseUrl("addresses");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      await SharedPref.setKey(
        value: response.body,
        key: SharedConsts.addresses,
      );
      List<AddressModel> address = [];
      for (var element in result["data"]) {
        address.add(AddressModel.fromJson(element));
      }
      return address;
    } else {
      return [];
    }
  }

  Future deleteAddress(int id) async {
    var url = AppNetWork.getBaseUrl("addresses/$id");
    await http.delete(
      url,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future<Map> addAddress({
    required String type,
    required String mainAdress,
    required String state,
    required String city,
    required bool isDefault,
    required String phone,
  }) async {
    var url = AppNetWork.getBaseUrl("addresses");
    var body = json.encode({
      "type": type,
      "region": "",
      "main_adress": mainAdress,
      "state": state,
      "city": city,
      "zip_code": "",
      "is_default": isDefault,
      "secondery_adress": "",
      "phone": phone,
    });

    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  Future updateAddress({required AddressModel addressModel}) async {
    var url = AppNetWork.getBaseUrl("addresses/${addressModel.id}");
    var body = json.encode({
      "type": addressModel.type,
      "region": "",
      "main_adress": addressModel.mainAdress,
      "state": addressModel.state,
      "city": addressModel.city,
      "zip_code": "",
      "secondery_adress": "",
      "phone": addressModel.phone,
    });

    await http.put(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future markAsDefalt({required bool isDefault, required int id}) async {
    var url = AppNetWork.getBaseUrl("addresses/$id");
    var body = json.encode({"is_default": isDefault});

    await http.put(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
  }

  Future<List<CitiesModel>> getLocalCities() async {
    final String response =
        await rootBundle.loadString('assets/json/cities.json');
    var data = json.decode(response);
    List<CitiesModel> cities = [];
    for (var element in data) {
      cities.add(CitiesModel.fromJson(element));
    }
    return cities;
  }
}
