import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';
import 'package:troond/views/chat/ui/widgets/chat_bubble_status.dart';
import 'package:troond/views/chat/ui/widgets/chat_image_bubble.dart';
import 'package:troond/views/chat/ui/widgets/voice_note_bubble.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isPlayingVoice;
  final double playbackProgress;
  final VoidCallback onToggleVoice;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isPlayingVoice,
    required this.playbackProgress,
    required this.onToggleVoice,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.isMe;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFFFFF2EB) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
                border: Border.all(
                  color: isMe ? const Color(0xFFFFD8BF) : const Color(0xFFE5E7EB),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (message.productContext != null)
                    _buildProductContextInBubble(),
                  if (message.type == ChatMessageType.text)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 10,
                        bottom: 4,
                      ),
                      child: Text(
                        message.content,
                        style: const TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 14.5,
                          height: 1.4,
                        ),
                      ),
                    )
                  else if (message.type == ChatMessageType.image)
                    ChatImageBubble(message: message)
                  else if (message.type == ChatMessageType.voice)
                    VoiceNoteBubble(
                      message: message,
                      isPlaying: isPlayingVoice,
                      playbackProgress: playbackProgress,
                      onTogglePlay: onToggleVoice,
                    ),
                  ChatBubbleStatus(message: message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductContextInBubble() {
    final p = message.productContext!;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 44,
              height: 44,
              color: const Color(0xFFF9FAFB),
              child: p.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: p.image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.image_not_supported_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(
                      Icons.shopping_bag_outlined,
                      size: 20,
                      color: AppColor.main,
                    ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "${p.price} ${AppStrings.currecy}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColor.main,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
