import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class ChatDateDivider extends StatelessWidget {
  final DateTime date;

  const ChatDateDivider({super.key, required this.date});

  static bool shouldShow(DateTime current, DateTime previous) {
    return current.day != previous.day ||
        current.month != previous.month ||
        current.year != previous.year;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isEnglish = SharedPref.getLanguage() == 'en';
    String label;

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      label = isEnglish ? "Today" : "اليوم";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      label = isEnglish ? "Yesterday" : "أمس";
    } else {
      label = DateFormat('dd MMMM yyyy', isEnglish ? 'en' : 'ar').format(date);
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF4B5563),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
