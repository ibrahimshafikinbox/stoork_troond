import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/views/help/model/chat_model.dart';

class HelpServices {
  Future<Map> createChat() async {
    var url = AppNetWork.getBaseUrl("tech-support/chat");
    var body = jsonEncode({
      "description": "description",
      "title": "title",
    });
    http.Response response = await http.post(
      url,
      body: body,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result["data"];
    } else {
      return {};
    }
  }

  Future<bool> sendText({required String content, required int chatId}) async {
    var url = AppNetWork.getBaseUrl("tech-support/tect-chat/$chatId/messages");
    var body = jsonEncode({"content": content});
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

  Future<bool> sendFile({required int chatId, required String file}) async {
    var url = AppNetWork.getBaseUrl("sales-chat/$chatId/files");

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', file));
    request.headers.addAll(AppNetWork.headerAuth()!);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ChatModel>> getChat(int id) async {

    var url = AppNetWork.getBaseUrl("tech-support/chat/$id");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<ChatModel> allChat = [];
      for (var element in result["data"]) {
        allChat.add(ChatModel.fromJson(element));
      }
      return allChat;
    } else {
      return [];
    }
  }
}
