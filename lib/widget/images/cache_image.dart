import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/widget/loading/loading_widget.dart';

class BuildCacheImage extends StatelessWidget {
  const BuildCacheImage({
    super.key,
    required this.height,
    required this.imageUrl,
    required this.width,
  });
  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || !imageUrl.startsWith('http')) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder: (context, url) => const LoadingWidget(),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }
}
