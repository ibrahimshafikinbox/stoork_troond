import 'package:troond/data/shared_pref/shared_pref.dart';

class AppNetWork {
  static const String baseUrl = "https://api.troond.com/api/v1/";
  static Uri getBaseUrl(String path) {
    Uri url = Uri.parse("${AppNetWork.baseUrl}$path");
    return url;
  }

  static Map<String, String> get header {
    String lang = SharedPref.getLanguage();
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': lang,
      'lang': lang,
    };
  }

  static Map<String, String> headerAuth() {
    String? token = SharedPref.getToken();
    String lang = SharedPref.getLanguage();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': lang,
      'lang': lang,
    };
    if (token != null && token.trim().isNotEmpty && token.trim() != "null") {
      headers['Authorization'] = 'Bearer ${token.trim()}';
      print("🔑 [AppNetWork.headerAuth] Bearer Token attached (Length: ${token.trim().length}, Prefix: ${token.trim().substring(0, token.trim().length > 15 ? 15 : token.trim().length)}...)");
    } else {
      print("⚠️ [AppNetWork.headerAuth] WARNING: Token is null or empty! Authorization header NOT attached.");
    }
    return headers;
  }
}
