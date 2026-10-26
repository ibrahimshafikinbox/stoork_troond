import 'package:shared_preferences/shared_preferences.dart';
import 'package:troond/config/app_const/shared_const.dart';

class SharedPref {
  static late SharedPreferences _prefes;

  static Future init() async {
    _prefes = await SharedPreferences.getInstance();
  }

  //* token
  static setToken(String value) async {
    print("💾 [SharedPref] Saving new auth token (Length: ${value.length}): ${value.substring(0, value.length > 15 ? 15 : value.length)}...");
    await _prefes.setString(SharedConsts.token, value);
  }

  static String? getToken() {
    String? token = _prefes.getString(SharedConsts.token);
    return token;
  }

  //* is login
  static bool isLogin() {
    String? token = getToken();
    bool loggedIn = token != null && token.trim().isNotEmpty && token.trim() != "null";
    print("👤 [SharedPref] Checking login status: ${loggedIn ? 'LOGGED IN ✅' : 'NOT LOGGED IN ❌'} (Token: ${token != null && token.length > 15 ? '${token.substring(0, 15)}...' : token})");
    return loggedIn;
  }

  //* user info
  static setUserInfo(String value) async {
    await _prefes.setString(SharedConsts.user, value);
  }

  static String? getUserInfo() {
    return _prefes.getString(SharedConsts.user);
  }

  static setUserId(int value) async {
    await _prefes.setInt(SharedConsts.id, value);
  }

  static int? getUserId() {
    return _prefes.getInt(SharedConsts.id);
  }

  static setKey({required String value, required String key}) async {
    await _prefes.setString(key, value);
  }

  static String? getKey({required String key}) {
    return _prefes.getString(key);
  }

  static setlanguage(String value) async {
    await _prefes.setString(SharedConsts.lang, value);
  }

  static String getLanguage() {
    return _prefes.getString(SharedConsts.lang) ?? "en";
  }

  static setSupplierId(int value) async {
    await _prefes.setInt(SharedConsts.suppliers, value);
  }

  static int? getSupplierId() {
    return _prefes.getInt(SharedConsts.suppliers);
  }

  static Future<bool> removeKey(String key) async {
    return await _prefes.remove(key);
  }

  //* clear
  static Future clear() async {
    await _prefes.clear();
  }
}
