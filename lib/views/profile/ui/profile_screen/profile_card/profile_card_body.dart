import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import '../../../../../config/app_local/app_local.dart';
import '../../../model/user_model.dart';

class ProfileCardBody extends StatelessWidget {
  const ProfileCardBody({
    super.key,
    required this.isEdit,
    required this.editPhoto,
    required this.user,
  });

  final bool isEdit;
  final Function()? editPhoto;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.getLocal(context);
    final hasImage = user.image != null && user.image!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColor.main.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.main,
                      AppColor.main.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: hasImage
                        ? CachedNetworkImage(
                            imageUrl: user.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColor.cF6F6F6,
                              child: const Icon(Icons.person, color: AppColor.cB8B8B8),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColor.cF6F6F6,
                              child: const Icon(Icons.person, color: AppColor.cB8B8B8),
                            ),
                          )
                        : Container(
                            color: AppColor.main.withOpacity(0.1),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 36,
                              color: AppColor.main,
                            ),
                          ),
                  ),
                ),
              ),
              if (isEdit)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: editPhoto,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.main,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.fullName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.c1E1E1E,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                if (user.email != null && user.email!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.email!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColor.c717171,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColor.main.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        size: 12,
                        color: AppColor.main,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        local.activeAccount,
                        style: const TextStyle(
                          color: AppColor.main,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

