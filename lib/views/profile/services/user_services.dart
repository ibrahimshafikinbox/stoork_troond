import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/profile/model/user_model.dart';

class UserServices {
  //* get info
  Future<UserModel?> getUserInfo() async {
    var url = AppNetWork.getBaseUrl("profile");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      if (result.containsKey("success") && result["success"] == true) {
        await SharedPref.setKey(
          value: response.body,
          key: SharedConsts.profile,
        );
        UserModel userModel = UserModel.fromJson(result["data"]);
        return userModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future updateImage({required int userId, required String image}) async {
    var url = AppNetWork.getBaseUrl("profile/$userId?_method=put");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.headers.addAll(AppNetWork.headerAuth()!);
    await request.send();
  }

  Future updateInfo({
    required int userId,
    required String? name,
    required String? email,
  }) async {
    var url = AppNetWork.getBaseUrl("profile/$userId?_method=patch");
    var body = jsonEncode({
      'name': name,
      'email': email,
    });
    await http.patch(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
  }

  Future updatePhone({required int userId, required String? phone}) async {
    var url = AppNetWork.getBaseUrl("profile/$userId?_method=patch");
    var body = jsonEncode({'phone_number': phone});
    await http.patch(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
  }

  Future updatePassword({
    required String? oldPassword,
    required String password,
  }) async {
    var url = AppNetWork.getBaseUrl("profile");
    var body = jsonEncode({
      'old_password': oldPassword,
      "password": password,
    });
    await http.post(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
  }
}
