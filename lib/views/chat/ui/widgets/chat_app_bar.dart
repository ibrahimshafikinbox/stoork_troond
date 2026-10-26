import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/chat/model/chat_seller_info.dart';
import 'package:troond/views/chat/ui/widgets/chat_more_menu.dart';
import 'package:troond/views/chat/ui/widgets/chat_seller_info_sheet.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatSellerInfo seller;

  const ChatAppBar({super.key, required this.seller});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    final isEnglish = SharedPref.getLanguage() == 'en';
    final initials = seller.name.trim().isNotEmpty
        ? seller.name.trim().substring(0, seller.name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : "TR";

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withOpacity(0.08),
      leadingWidth: 48,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF1F2937),
          ),
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 22,
        ),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: () => ChatSellerInfoSheet.show(context, seller),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            children: [
              _buildAvatar(initials),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            seller.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        if (seller.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified_rounded, color: Color(0xFF0284C7), size: 15),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: seller.isOnline ? const Color(0xFF10B981) : Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          seller.isOnline
                              ? (isEnglish ? "Online" : "متصل الآن")
                              : (isEnglish ? "Offline" : "غير متصل"),
                          style: TextStyle(
                            fontSize: 11,
                            color: seller.isOnline ? const Color(0xFF059669) : Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline_rounded, color: Color(0xFF4B5563), size: 22),
          onPressed: () => ChatSellerInfoSheet.show(context, seller),
          tooltip: isEnglish ? "Store Info" : "معلومات المتجر",
        ),
        const ChatMoreMenu(),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildAvatar(String initials) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF3F4F6),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
          ),
          child: ClipOval(
            child: seller.logo != null && seller.logo!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: seller.logo!,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => _buildInitials(initials),
                  )
                : _buildInitials(initials),
          ),
        ),
        if (seller.isOnline)
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitials(String initials) {
    return Center(
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColor.main,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
