import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/product/model/product_preview.dart';

class MainServices {
  Future<List<ProductPreview>> search(String name) async {
    var url = AppNetWork.getBaseUrl("search?name=$name");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.header,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<ProductPreview> products = [];
      for (var element in result["data"]) {
        products.add(ProductPreview.fromJson(element));
      }
      return products;
    } else {
      return [];
    }
  }
}
