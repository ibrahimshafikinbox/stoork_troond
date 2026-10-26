import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';

class ChatBubbleStatus extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubbleStatus({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('hh:mm a', 'ar').format(message.createdAt);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            timeStr,
            style: const TextStyle(
              fontSize: 10.5,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 4),
            _buildStatusIcon(message.status),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ChatMessageStatus status) {
    switch (status) {
      case ChatMessageStatus.sending:
        return const SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Color(0xFF9CA3AF),
          ),
        );
      case ChatMessageStatus.sent:
        return const Icon(
          Icons.check_rounded,
          size: 13,
          color: Color(0xFF9CA3AF),
        );
      case ChatMessageStatus.delivered:
        return const Icon(
          Icons.done_all_rounded,
          size: 14,
          color: Color(0xFF9CA3AF),
        );
      case ChatMessageStatus.read:
        return const Icon(
          Icons.done_all_rounded,
          size: 14,
          color: AppColor.main,
        );
      case ChatMessageStatus.error:
        return const Icon(
          Icons.error_outline_rounded,
          size: 14,
          color: Colors.redAccent,
        );
    }
  }
}
