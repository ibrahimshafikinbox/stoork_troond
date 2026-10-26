import 'package:troond/views/chat/model/chat_product_context.dart';

enum ChatMessageType {
  text,
  image,
  voice,
  productInquiry,
}

enum ChatMessageStatus {
  sending,
  sent,
  delivered,
  read,
  error,
}

class ChatMessageModel {
  final String id;
  final int? chatId;
  final int? senderId;
  final bool isMe;
  final ChatMessageType type;
  final String content;
  final String? mediaUrl;
  final String? localFilePath;
  final int? voiceDurationSeconds;
  final List<double>? waveform;
  final DateTime createdAt;
  ChatMessageStatus status;
  final ChatProductContext? productContext;

  ChatMessageModel({
    required this.id,
    this.chatId,
    this.senderId,
    required this.isMe,
    required this.type,
    required this.content,
    this.mediaUrl,
    this.localFilePath,
    this.voiceDurationSeconds,
    this.waveform,
    required this.createdAt,
    this.status = ChatMessageStatus.sent,
    this.productContext,
  });

  String? get fileUrl => mediaUrl;

  String get formattedDuration {
    if (voiceDurationSeconds == null || voiceDurationSeconds == 0) {
      return "0:00";
    }
    final int minutes = voiceDurationSeconds! ~/ 60;
    final int seconds = voiceDurationSeconds! % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json, {int? currentUserId}) {
    int sender = json['sender_id'] ?? json['user_id'] ?? 0;
    bool isUserSender = currentUserId != null
        ? sender == currentUserId
        : (json['is_me'] ?? false);

    ChatMessageType type = ChatMessageType.text;
    String rawType = (json['type'] ?? '').toString().toLowerCase();
    if (rawType == 'image' || json['file_type'] == 'image') {
      type = ChatMessageType.image;
    } else if (rawType == 'voice' || rawType == 'audio' || json['file_type'] == 'audio') {
      type = ChatMessageType.voice;
    } else if (rawType == 'product' || json['product'] != null) {
      type = ChatMessageType.productInquiry;
    }

    return ChatMessageModel(
      id: json['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: json['chat_id'],
      senderId: sender,
      isMe: isUserSender,
      type: type,
      content: json['content'] ?? json['message'] ?? '',
      mediaUrl: json['media_url'] ?? json['file_url'] ?? json['file']?['path'],
      voiceDurationSeconds: json['voice_duration'] ?? json['duration'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : (json['date'] != null ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now() : DateTime.now()),
      status: _parseStatus(json['status']),
      productContext: json['product'] != null
          ? ChatProductContext.fromJson(json['product'])
          : null,
    );
  }

  static ChatMessageStatus _parseStatus(dynamic status) {
    if (status == null) return ChatMessageStatus.sent;
    String s = status.toString().toLowerCase();
    if (s == 'read' || s == 'seen') return ChatMessageStatus.read;
    if (s == 'delivered') return ChatMessageStatus.delivered;
    if (s == 'sending') return ChatMessageStatus.sending;
    if (s == 'error') return ChatMessageStatus.error;
    return ChatMessageStatus.sent;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'is_me': isMe,
      'type': type.name,
      'content': content,
      'media_url': mediaUrl,
      'local_file_path': localFilePath,
      'voice_duration': voiceDurationSeconds,
      'created_at': createdAt.toIso8601String(),
      'status': status.name,
      'product': productContext?.toJson(),
    };
  }
}
