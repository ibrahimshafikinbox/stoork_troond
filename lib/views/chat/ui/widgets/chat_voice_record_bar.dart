import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class ChatVoiceRecordBar extends StatefulWidget {
  final int recordingSeconds;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  const ChatVoiceRecordBar({
    super.key,
    required this.recordingSeconds,
    required this.onCancel,
    required this.onSend,
  });

  @override
  State<ChatVoiceRecordBar> createState() => _ChatVoiceRecordBarState();
}

class _ChatVoiceRecordBarState extends State<ChatVoiceRecordBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';
    final mins = (widget.recordingSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (widget.recordingSeconds % 60).toString().padLeft(2, '0');

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        children: [
          FadeTransition(
            opacity: _pulseController,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$mins:$secs",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFDC2626),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isEnglish ? "Recording voice note..." : "جاري تسجيل صوتي...",
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 22),
            onPressed: widget.onCancel,
            tooltip: isEnglish ? "Cancel" : "إلغاء",
          ),
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColor.main,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 20),
              onPressed: widget.onSend,
              tooltip: isEnglish ? "Send Voice" : "إرسال الصوت",
            ),
          ),
        ],
      ),
    );
  }
}
