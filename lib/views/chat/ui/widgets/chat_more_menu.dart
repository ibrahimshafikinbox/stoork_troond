import 'package:flutter/material.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/widget/toast/build_toast.dart';

class ChatMoreMenu extends StatelessWidget {
  const ChatMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';

    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Color(0xFF4B5563),
        size: 22,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 6,
      onSelected: (value) {
        if (value == 'mute') {
          BuildToast.success(
            title: isEnglish
                ? "Notifications muted"
                : "تم كتم إشعارات المحادثة",
          );
        } else if (value == 'clear') {
          BuildToast.success(
            title: isEnglish ? "Chat cleared" : "تم مسح المحادثة",
          );
        } else if (value == 'report') {
          BuildToast.success(
            title: isEnglish ? "Report submitted" : "تم إرسال البلاغ للإدارة",
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'mute',
          child: Row(
            children: [
              const Icon(Icons.notifications_off_outlined, size: 18, color: Color(0xFF4B5563)),
              const SizedBox(width: 10),
              Text(
                isEnglish ? "Mute Chat" : "كتم الإشعارات",
                style: const TextStyle(fontSize: 13, color: Color(0xFF1F2937)),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'clear',
          child: Row(
            children: [
              const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFF4B5563)),
              const SizedBox(width: 10),
              Text(
                isEnglish ? "Clear Chat" : "مسح المحادثة",
                style: const TextStyle(fontSize: 13, color: Color(0xFF1F2937)),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              const Icon(Icons.flag_outlined, size: 18, color: Color(0xFFEF4444)),
              const SizedBox(width: 10),
              Text(
                isEnglish ? "Report Seller" : "إبلاغ عن المتجر",
                style: const TextStyle(fontSize: 13, color: Color(0xFFEF4444)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
