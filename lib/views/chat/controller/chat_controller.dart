import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/chat/controller/chat_voice_manager.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';
import 'package:troond/views/chat/model/chat_product_context.dart';
import 'package:troond/views/chat/model/chat_seller_info.dart';
import 'package:troond/views/chat/services/chat_service.dart';

class ChatController extends ChangeNotifier {
  final ChatService _service = ChatService();
  final ImagePicker _picker = ImagePicker();
  late final ChatVoiceManager _voiceManager;

  late ChatSellerInfo seller;
  ChatProductContext? product;
  int chatId = 1;

  bool isLoading = false;
  List<ChatMessageModel> messages = [];

  ChatController() {
    _voiceManager = ChatVoiceManager(onStateChanged: notifyListeners);
  }

  // Voice Getters
  bool get isRecording => _voiceManager.isRecording;
  int get recordingSeconds => _voiceManager.recordingSeconds;
  String? get playingMessageId => _voiceManager.playingMessageId;
  bool get isPlaying => _voiceManager.isPlaying;
  double get playbackProgress => _voiceManager.playbackProgress;

  void init({
    required ChatSellerInfo sellerInfo,
    ChatProductContext? productContext,
  }) {
    seller = sellerInfo;
    product = productContext;
    loadMessages();
  }

  Future<void> loadMessages() async {
    isLoading = true;
    notifyListeners();

    final remoteChat = await _service.createOrGetChat(
      sellerId: seller.id,
      productId: product?.id,
    );

    if (remoteChat != null && remoteChat['id'] != null) {
      chatId = remoteChat['id'];
      final remoteMessages = await _service.getMessages(chatId);
      if (remoteMessages.isNotEmpty) {
        messages = remoteMessages;
        isLoading = false;
        notifyListeners();
        return;
      }
    }

    _initDefaultMessages();
    isLoading = false;
    notifyListeners();
  }

  void _initDefaultMessages() {
    final now = DateTime.now();
    messages = [
      ChatMessageModel(
        id: "msg_1",
        chatId: chatId,
        senderId: seller.id,
        isMe: false,
        type: ChatMessageType.text,
        content: "أهلاً بك في ${seller.name}! 👋 كيف يمكننا مساعدتك اليوم بخصوص طلبك؟",
        createdAt: now.subtract(const Duration(minutes: 5)),
        status: ChatMessageStatus.read,
      ),
    ];

    if (product != null) {
      messages.add(
        ChatMessageModel(
          id: "msg_prod",
          chatId: chatId,
          senderId: SharedPref.getUserId() ?? 0,
          isMe: true,
          type: ChatMessageType.productInquiry,
          content: "مرحباً، أود الاستفسار عن تفاصيل هذا المنتج.",
          productContext: product,
          createdAt: now.subtract(const Duration(minutes: 4)),
          status: ChatMessageStatus.read,
        ),
      );
    }
  }

  Future<void> sendText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final tempId = "msg_${DateTime.now().millisecondsSinceEpoch}";
    final newMessage = ChatMessageModel(
      id: tempId,
      chatId: chatId,
      senderId: SharedPref.getUserId() ?? 0,
      isMe: true,
      type: ChatMessageType.text,
      content: trimmed,
      createdAt: DateTime.now(),
      status: ChatMessageStatus.sending,
    );

    messages.add(newMessage);
    notifyListeners();

    final remoteRes = await _service.sendTextMessage(
      chatId: chatId,
      content: trimmed,
      productContext: product,
    );

    final index = messages.indexWhere((m) => m.id == tempId);
    if (index != -1) {
      messages[index] = remoteRes ?? messages[index]..status = ChatMessageStatus.sent;
    }
    notifyListeners();
    _simulateSellerResponseIfNeeded(trimmed);
  }

  void sendQuickInquiry(String text) => sendText(text);

  Future<void> pickAndSendImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (file == null) return;

      final tempId = "img_${DateTime.now().millisecondsSinceEpoch}";
      final newMessage = ChatMessageModel(
        id: tempId,
        chatId: chatId,
        senderId: SharedPref.getUserId() ?? 0,
        isMe: true,
        type: ChatMessageType.image,
        content: "صورة",
        localFilePath: file.path,
        createdAt: DateTime.now(),
        status: ChatMessageStatus.sending,
      );

      messages.add(newMessage);
      notifyListeners();

      final remoteRes = await _service.sendImageMessage(
        chatId: chatId,
        imagePath: file.path,
      );

      final index = messages.indexWhere((m) => m.id == tempId);
      if (index != -1) {
        messages[index] = remoteRes ?? messages[index]..status = ChatMessageStatus.sent;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // Voice Actions
  void startRecording() => _voiceManager.startRecording();
  void cancelRecording() => _voiceManager.cancelRecording();

  Future<void> stopAndSendRecording() async {
    final duration = _voiceManager.stopRecording();
    final random = Random();
    final randomWave = List.generate(24, (_) => 0.2 + random.nextDouble() * 0.8);
    final tempId = "voice_${DateTime.now().millisecondsSinceEpoch}";

    final newMessage = ChatMessageModel(
      id: tempId,
      chatId: chatId,
      senderId: SharedPref.getUserId() ?? 0,
      isMe: true,
      type: ChatMessageType.voice,
      content: "تسجيل صوتي",
      voiceDurationSeconds: duration,
      waveform: randomWave,
      createdAt: DateTime.now(),
      status: ChatMessageStatus.sent,
    );

    messages.add(newMessage);
    notifyListeners();

    await _service.sendVoiceMessage(
      chatId: chatId,
      voicePath: "mock_voice_$tempId.m4a",
      durationSeconds: duration,
    );
  }

  void togglePlayVoice(ChatMessageModel message) => _voiceManager.togglePlayVoice(message);

  void _simulateSellerResponseIfNeeded(String userText) {
    Timer(const Duration(seconds: 2), () {
      String response = "شكراً لتواصلك معنا! سيقوم فريق المبيعات بالرد على استفسارك قريباً.";
      if (userText.contains("متوفر") || userText.contains("مخزون")) {
        response = "نعم، المنتج متوفر حالياً في مستودعاتنا وجاهز للشحن الفوري! 📦";
      } else if (userText.contains("توصيل") || userText.contains("شحن")) {
        response = "مدة التوصيل المعتادة هي من 2 إلى 4 أيام عمل لكافة المناطق. 🚚";
      } else if (userText.contains("خصم") || userText.contains("سعر")) {
        response = "الأسعار المعروضة منافسة وشاملة الضريبة، كما نوفر عروضاً خاصة للكميات. ✨";
      }

      messages.add(
        ChatMessageModel(
          id: "reply_${DateTime.now().millisecondsSinceEpoch}",
          chatId: chatId,
          senderId: seller.id,
          isMe: false,
          type: ChatMessageType.text,
          content: response,
          createdAt: DateTime.now(),
          status: ChatMessageStatus.read,
        ),
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _voiceManager.dispose();
    super.dispose();
  }
}
