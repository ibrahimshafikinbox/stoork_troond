import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/product/model/product_preview.dart';

class ProductImagesWidget extends StatefulWidget {
  const ProductImagesWidget({Key? key, required this.productPreview})
      : super(key: key);
  final ProductPreview productPreview;

  @override
  State<ProductImagesWidget> createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  late PageController _pageController;
  late ScrollController _thumbScrollController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
    _thumbScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbScrollController.dispose();
    super.dispose();
  }

  void _onImageTap(int newIndex) {
    if (newIndex == index) return;
    setState(() {
      index = newIndex;
    });
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _scrollToThumbnail(newIndex);
  }

  void _onPageChanged(int newIndex) {
    setState(() {
      index = newIndex;
    });
    _scrollToThumbnail(newIndex);
  }

  void _scrollToThumbnail(int newIndex) {
    if (_thumbScrollController.hasClients) {
      const double itemWidth = 68.0;
      double screenWidth = MediaQuery.of(context).size.width;
      double targetOffset =
          (newIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      if (targetOffset < 0) targetOffset = 0;
      double maxScroll = _thumbScrollController.position.maxScrollExtent;
      if (targetOffset > maxScroll) targetOffset = maxScroll;

      _thumbScrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.productPreview.images;

    if (images.isEmpty) {
      return Container(
        height: 320,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 60,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      children: [
        // 1. Main Image Viewer Container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: images.length,
                    itemBuilder: (context, i) {
                      return InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CachedNetworkImage(
                            imageUrl: images[i].path,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.main,
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Fav Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BuildFavBtn(
                      productId: widget.productPreview.id,
                      isFav: false,
                      iconSize: 22,
                      maxRadius: 18,
                    ),
                  ),
                ),

                // Image Count Badge (e.g. 1/4)
                if (images.length > 1)
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${index + 1}/${images.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // 2. Mini Thumbnails Horizontal List (أسفل الصورة قائمة مصغرة بكل الصور)
        if (images.length > 1) ...[
          SizedBox(
            height: 64,
            child: ListView.builder(
              controller: _thumbScrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: images.length,
              itemBuilder: (context, i) {
                final bool isSelected = i == index;
                return GestureDetector(
                  onTap: () => _onImageTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColor.main : Colors.grey.shade300,
                        width: isSelected ? 2.5 : 1.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColor.main.withValues(alpha: 0.25),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: CachedNetworkImage(
                        imageUrl: images[i].path,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 3. Dot Indicators (وأسفلهم دوت نقط حسب العدد)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (i) {
                final bool isSelected = i == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: isSelected ? 22 : 7,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.main : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
