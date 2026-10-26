import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/chat/controller/chat_controller.dart';
import 'package:troond/views/chat/ui/widgets/chat_attachment_sheet.dart';
import 'package:troond/views/chat/ui/widgets/chat_quick_chips.dart';
import 'package:troond/views/chat/ui/widgets/chat_voice_record_bar.dart';

class ChatInputBar extends StatefulWidget {
  final ChatController controller;

  const ChatInputBar({super.key, required this.controller});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _textController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final has = _textController.text.trim().isNotEmpty;
    if (has != _hasText) {
      setState(() => _hasText = has);
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;
    widget.controller.sendText(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';
    final isRecording = widget.controller.isRecording;

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isRecording && widget.controller.messages.length <= 2)
              ChatQuickChips(
                onSelectChip: (text) => widget.controller.sendQuickInquiry(text),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: isRecording
                  ? ChatVoiceRecordBar(
                      recordingSeconds: widget.controller.recordingSeconds,
                      onCancel: widget.controller.cancelRecording,
                      onSend: widget.controller.stopAndSendRecording,
                    )
                  : _buildNormalInputBar(isEnglish),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalInputBar(bool isEnglish) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.attach_file_rounded, color: Color(0xFF6B7280), size: 24),
          onPressed: () => ChatAttachmentSheet.show(
            context,
            onPickImage: widget.controller.pickAndSendImage,
          ),
          tooltip: isEnglish ? "Attach" : "إرفاق",
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: _textController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _handleSend(),
              maxLines: 4,
              minLines: 1,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
              decoration: InputDecoration(
                hintText: isEnglish ? "Type a message..." : "اكتب رسالتك هنا...",
                hintStyle: TextStyle(fontSize: 13.5, color: Colors.grey.shade400),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _hasText
            ? Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColor.main,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  onPressed: _handleSend,
                  tooltip: isEnglish ? "Send" : "إرسال",
                ),
              )
            : Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFEDD5)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.mic_rounded, color: AppColor.main, size: 22),
                  onPressed: widget.controller.startRecording,
                  tooltip: isEnglish ? "Record Voice Note" : "تسجيل صوتي",
                ),
              ),
      ],
    );
  }
}
