import 'package:flutter/material.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class ChatQuickChips extends StatelessWidget {
  final Function(String) onSelectChip;

  const ChatQuickChips({super.key, required this.onSelectChip});

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';
    final List<String> suggestions = isEnglish
        ? [
            "Is this item in stock?",
            "What is the delivery time?",
            "Any discounts on bulk orders?",
            "What is the warranty policy?",
          ]
        : [
            "هل المنتج متوفر بالمخزون؟",
            "ما هي مدة التوصيل المتوقعة؟",
            "هل يوجد خصم للكميات؟",
            "ما هي شروط الضمان؟",
          ];

    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final text = suggestions[index];
          return ActionChip(
            label: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: const Color(0xFFF3F4F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            onPressed: () => onSelectChip(text),
          );
        },
      ),
    );
  }
}
