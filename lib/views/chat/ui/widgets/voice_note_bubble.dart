import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';

class VoiceNoteBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isPlaying;
  final double playbackProgress;
  final VoidCallback onTogglePlay;

  const VoiceNoteBubble({
    super.key,
    required this.message,
    required this.isPlaying,
    required this.playbackProgress,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final waveSamples = message.waveform ??
        const [
          0.3, 0.5, 0.8, 0.4, 0.9, 0.6, 0.3, 0.7, 0.8, 0.5,
          0.3, 0.6, 0.9, 0.4, 0.7, 0.5, 0.3, 0.6, 0.8, 0.4
        ];

    final Color playBtnBg = isMe ? AppColor.main : const Color(0xFF3B82F6);
    final Color activeWaveColor = isMe ? AppColor.main : const Color(0xFF2563EB);
    final Color inactiveWaveColor = isMe ? const Color(0xFFFFD8BF) : const Color(0xFFD1D5DB);

    return Container(
      width: 230,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          // Play / Pause Button
          GestureDetector(
            onTap: onTogglePlay,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: playBtnBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: playBtnBg.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Waveform and Duration
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Waveform bars
                SizedBox(
                  height: 26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(waveSamples.length, (index) {
                      final double sample = waveSamples[index];
                      final double barHeight = 8 + (sample * 18);
                      final double itemFraction = index / waveSamples.length;
                      final bool isPast = isPlaying && itemFraction <= playbackProgress;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 2.8,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: isPast ? activeWaveColor : inactiveWaveColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 4),

                // Duration text & mic indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.formattedDuration,
                      style: TextStyle(
                        fontSize: 11,
                        color: isMe ? const Color(0xFF9A3412) : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mic_rounded,
                          size: 13,
                          color: isMe ? AppColor.main : Colors.grey.shade500,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "صوتي",
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe ? AppColor.main : Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
