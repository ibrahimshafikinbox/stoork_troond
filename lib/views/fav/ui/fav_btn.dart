import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/fav/controller/fav_controller.dart';
import '../../../config/theme/app_color.dart';

class BuildFavBtn extends StatelessWidget {
  const BuildFavBtn({
    super.key,
    required this.productId,
    required this.isFav,
    this.iconSize = 16,
    this.maxRadius = 16,
    this.backgroundColor = AppColor.white,
  });
  final int productId;
  final bool isFav;
  final double iconSize;
  final double maxRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavController>(
      builder: (context, favController, child) {
        bool activeFav = favController.isInitialized
            ? favController.isFavorite(productId)
            : (favController.isFavorite(productId) || isFav);
        bool isLoading = favController.isAdding == productId;

        return InkWell(
          onTap: isLoading
              ? null
              : () {
                  if (activeFav) {
                    favController.delete(
                      productId: productId,
                      context: context,
                    );
                  } else {
                    favController.addToFav(
                      productId: productId,
                      context: context,
                    );
                  }
                },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.c64646D,
                    blurRadius: 0.9,
                  ),
                ],
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? _HeartFillLoading(
                        size: iconSize,
                        color: AppColor.cD21318,
                      )
                    : Icon(
                        activeFav
                            ? BootstrapIcons.heart_fill
                            : BootstrapIcons.heart,
                        color: activeFav ? AppColor.cD21318 : AppColor.c121212,
                        size: iconSize,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeartFillLoading extends StatefulWidget {
  const _HeartFillLoading({
    required this.size,
    required this.color,
  });
  final double size;
  final Color color;

  @override
  State<_HeartFillLoading> createState() => _HeartFillLoadingState();
}

class _HeartFillLoadingState extends State<_HeartFillLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outlined heart background
              Icon(
                BootstrapIcons.heart,
                color: widget.color.withValues(alpha: 0.35),
                size: widget.size,
              ),
              // Animated red heart fill rising from bottom to top
              ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: _fillAnimation.value,
                  child: Icon(
                    BootstrapIcons.heart_fill,
                    color: widget.color,
                    size: widget.size,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
