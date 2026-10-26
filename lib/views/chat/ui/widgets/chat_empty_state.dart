import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF7ED),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColor.main,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isEnglish ? "Start conversation" : "ابدأ المحادثة مع البائع",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isEnglish
                  ? "Ask about availability, delivery, or product details"
                  : "اسأل عن توفر المنتج، مدة الشحن، أو أي تفاصيل إضافية",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
