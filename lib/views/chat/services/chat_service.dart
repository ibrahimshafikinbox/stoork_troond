import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';
import 'package:troond/views/chat/model/chat_product_context.dart';

class ChatService {
  /// Initialize or fetch existing chat session between customer and seller
  Future<Map<String, dynamic>?> createOrGetChat({
    required int sellerId,
    int? productId,
  }) async {
    try {
      var url = AppNetWork.getBaseUrl("customer/chats");
      var body = jsonEncode({
        "seller_id": sellerId,
        if (productId != null) "product_id": productId,
      });

      http.Response response = await http.post(
        url,
        body: body,
        headers: AppNetWork.headerAuth(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return result['data'];
      }
    } catch (e) {
      debugPrint("⚠️ [ChatService] createOrGetChat API not reachable or pending: $e");
    }
    return null;
  }

  /// Get messages list for a given chat ID
  Future<List<ChatMessageModel>> getMessages(int chatId) async {
    try {
      var url = AppNetWork.getBaseUrl("customer/chats/$chatId/messages");
      http.Response response = await http.get(
        url,
        headers: AppNetWork.headerAuth(),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List<ChatMessageModel> messages = [];
        int? currentUserId = SharedPref.getUserId();
        if (result['data'] is List) {
          for (var element in result['data']) {
            messages.add(ChatMessageModel.fromJson(element, currentUserId: currentUserId));
          }
        }
        return messages;
      }
    } catch (e) {
      debugPrint("⚠️ [ChatService] getMessages error: $e");
    }
    return [];
  }

  /// Send text message to seller
  Future<ChatMessageModel?> sendTextMessage({
    required int chatId,
    required String content,
    ChatProductContext? productContext,
  }) async {
    try {
      var url = AppNetWork.getBaseUrl("customer/chats/$chatId/messages");
      var body = jsonEncode({
        "content": content,
        "type": "text",
        if (productContext != null) "product_id": productContext.id,
      });

      http.Response response = await http.post(
        url,
        body: body,
        headers: AppNetWork.headerAuth(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return ChatMessageModel.fromJson(result['data'], currentUserId: SharedPref.getUserId());
      }
    } catch (e) {
      debugPrint("⚠️ [ChatService] sendTextMessage error: $e");
    }
    return null;
  }

  /// Send image message to seller via multipart request
  Future<ChatMessageModel?> sendImageMessage({
    required int chatId,
    required String imagePath,
    String? caption,
  }) async {
    try {
      var url = AppNetWork.getBaseUrl("customer/chats/$chatId/files");
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      if (caption != null && caption.isNotEmpty) {
        request.fields['caption'] = caption;
      }
      request.fields['type'] = 'image';

      final headers = AppNetWork.headerAuth();
      if (headers != null) {
        request.headers.addAll(headers);
      }

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        var result = jsonDecode(responseData);
        return ChatMessageModel.fromJson(result['data'], currentUserId: SharedPref.getUserId());
      }
    } catch (e) {
      debugPrint("⚠️ [ChatService] sendImageMessage error: $e");
    }
    return null;
  }

  /// Send voice note to seller
  Future<ChatMessageModel?> sendVoiceMessage({
    required int chatId,
    required String voicePath,
    required int durationSeconds,
  }) async {
    try {
      var url = AppNetWork.getBaseUrl("customer/chats/$chatId/voice");
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('voice', voicePath));
      request.fields['duration'] = durationSeconds.toString();
      request.fields['type'] = 'voice';

      final headers = AppNetWork.headerAuth();
      if (headers != null) {
        request.headers.addAll(headers);
      }

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        var result = jsonDecode(responseData);
        return ChatMessageModel.fromJson(result['data'], currentUserId: SharedPref.getUserId());
      }
    } catch (e) {
      debugPrint("⚠️ [ChatService] sendVoiceMessage error: $e");
    }
    return null;
  }
}
