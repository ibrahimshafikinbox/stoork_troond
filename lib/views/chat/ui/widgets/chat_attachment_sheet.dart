import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class ChatAttachmentSheet extends StatelessWidget {
  final Function(ImageSource) onPickImage;

  const ChatAttachmentSheet({super.key, required this.onPickImage});

  static void show(BuildContext context, {required Function(ImageSource) onPickImage}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => ChatAttachmentSheet(onPickImage: onPickImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isEnglish ? "Share with Seller" : "إرسال إلى البائع",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(
                  context: context,
                  icon: Icons.camera_alt_rounded,
                  label: isEnglish ? "Camera" : "الكاميرا",
                  color: const Color(0xFF0284C7),
                  source: ImageSource.camera,
                ),
                _buildItem(
                  context: context,
                  icon: Icons.photo_library_rounded,
                  label: isEnglish ? "Gallery" : "المعرض",
                  color: const Color(0xFF10B981),
                  source: ImageSource.gallery,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required ImageSource source,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onPickImage(source);
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
