import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String? imageUrl;
  final String? localFilePath;

  const ImageViewerScreen({
    super.key,
    this.imageUrl,
    this.localFilePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: localFilePath != null && localFilePath!.isNotEmpty
              ? Image.file(
                  File(localFilePath!),
                  fit: BoxFit.contain,
                )
              : (imageUrl != null && imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.contain,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.broken_image_rounded,
                        color: Colors.white54,
                        size: 60,
                      ),
                    )
                  : const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.white54,
                      size: 60,
                    )),
        ),
      ),
    );
  }
}
