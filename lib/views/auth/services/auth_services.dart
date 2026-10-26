import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class AuthServices {
  //* register
  Future<Map> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("${AppNetWork.baseUrl}user/create");
    var body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result;
    } else if (response.statusCode == 422) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  //* login

  Future login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("${AppNetWork.baseUrl}user/login");
    var body = jsonEncode({
      "email": email,
      "password": password,
    });
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else if (response.statusCode == 401) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  //* forget password
  Future forgetPasword({required String email}) async {
    var url = Uri.parse("${AppNetWork.baseUrl}password-reset/link");
    var body = jsonEncode({"email": email});
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  Future<Map> sendOtpForgetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    var url = Uri.parse("${AppNetWork.baseUrl}password-reset");
    var body = jsonEncode({
      "email": email,
      "code": code,
      "password": password,
    });

    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.header,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return {};
    }
  }

  Future deleteAccount() async {
    var url = Uri.parse('${AppNetWork.baseUrl}user/profile');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getToken()}'
    };
    var request = http.Request('DELETE', url);

    request.headers.addAll(headers);
    await request.send();
  }
}
