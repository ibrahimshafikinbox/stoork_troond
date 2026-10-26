import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Reusable Shimmer Container widget powered by `shimmer` package.
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  });

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey.shade300,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

/// Generic wrapper to apply shimmer gradient effect to custom child widget trees
class CustomShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const CustomShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

/// Shimmer placeholder for Top Navigation Category Bar on Home Screen
class NavCategoryShimmerLoading extends StatelessWidget {
  const NavCategoryShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: SizedBox(
        height: 35,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, __) {
            return Container(
              width: 75,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Shimmer placeholder for Top Slider / Banner Carousel on Home Screen
class BannerSliderShimmerLoading extends StatelessWidget {
  const BannerSliderShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ShimmerWidget.rectangular(
              height: 170,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: index == 0 ? 18 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Shimmer placeholder for horizontal Categories on Home Screen
class CategoriesShimmerLoading extends StatelessWidget {
  const CategoriesShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShimmerWidget.rectangular(height: 18, width: 120),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) {
              return Container(
                width: 115,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerWidget.circular(width: 75, height: 75),
                    SizedBox(height: 10),
                    ShimmerWidget.rectangular(height: 12, width: 80),
                    SizedBox(height: 6),
                    ShimmerWidget.rectangular(height: 10, width: 50),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Shimmer placeholder for Daily Best Sells / Flash Sales section
class DailyBestSellsShimmerLoading extends StatelessWidget {
  const DailyBestSellsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget.rectangular(height: 20, width: 150),
              ShimmerWidget.rectangular(height: 16, width: 80),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) {
              return Container(
                width: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 130,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    ShimmerWidget.rectangular(height: 14, width: 130),
                    SizedBox(height: 6),
                    ShimmerWidget.rectangular(height: 12, width: 90),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerWidget.rectangular(height: 16, width: 65),
                        ShimmerWidget.circular(width: 32, height: 32),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Shimmer placeholder for Products Grid / Horizontal List
class ProductsShimmerLoading extends StatelessWidget {
  final bool isHorizontal;
  final int itemCount;

  const ProductsShimmerLoading({
    super.key,
    this.isHorizontal = true,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return SizedBox(
        height: 250,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, __) => _buildProductCardShimmer(),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => _buildProductCardShimmer(),
    );
  }

  Widget _buildProductCardShimmer() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ShimmerWidget.rectangular(
                height: 135,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: ShimmerWidget.circular(width: 26, height: 26),
              ),
            ],
          ),
          SizedBox(height: 10),
          ShimmerWidget.rectangular(height: 13, width: 130),
          SizedBox(height: 6),
          ShimmerWidget.rectangular(height: 11, width: 80),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget.rectangular(height: 16, width: 60),
              ShimmerWidget.circular(width: 30, height: 30),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for Brands section
class BrandsShimmerLoading extends StatelessWidget {
  const BrandsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ShimmerWidget.rectangular(height: 18, width: 130),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) {
              return Container(
                width: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerWidget.circular(width: 50, height: 50),
                    SizedBox(height: 8),
                    ShimmerWidget.rectangular(height: 10, width: 60),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Complete Home Skeleton Loader while home data is being fetched
class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          // Top Navigation Category Chips Shimmer
          NavCategoryShimmerLoading(),
          SizedBox(height: 14),
          // Banner Slider Shimmer
          BannerSliderShimmerLoading(),
          SizedBox(height: 18),
          // Categories Shimmer
          CategoriesShimmerLoading(),
          SizedBox(height: 20),
          // Daily Best Sells Shimmer
          DailyBestSellsShimmerLoading(),
          SizedBox(height: 22),
          // Popular Products Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(height: 20, width: 140),
                ShimmerWidget.rectangular(height: 16, width: 60),
              ],
            ),
          ),
          SizedBox(height: 12),
          // Popular Products Grid Shimmer
          ProductsShimmerLoading(isHorizontal: false, itemCount: 4),
          SizedBox(height: 22),
          // Popular Brands Shimmer
          BrandsShimmerLoading(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for Categories Grid View (Categories Screen)
class CategoryGridShimmerLoading extends StatelessWidget {
  final int itemCount;

  const CategoryGridShimmerLoading({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ShimmerWidget.rectangular(
                  height: 110,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 14, width: 100),
            ],
          ),
        );
      },
    );
  }
}

/// Shimmer placeholder for Categories List View (Categories Screen)
class CategoryListShimmerLoading extends StatelessWidget {
  final int itemCount;

  const CategoryListShimmerLoading({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
          ),
          child: const Row(
            children: [
              ShimmerWidget.rectangular(
                height: 75,
                width: 75,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(height: 14, width: 140),
                    SizedBox(height: 8),
                    ShimmerWidget.rectangular(height: 10, width: 80),
                  ],
                ),
              ),
              ShimmerWidget.circular(width: 20, height: 20),
            ],
          ),
        );
      },
    );
  }
}

/// Shimmer placeholder for Products Vertical List View (ProductCard3 style)
class ProductsListShimmerLoading extends StatelessWidget {
  final int itemCount;

  const ProductsListShimmerLoading({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1.0,
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangular(
                height: 120,
                width: 110,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(height: 14, width: 160),
                    SizedBox(height: 8),
                    ShimmerWidget.rectangular(height: 12, width: 100),
                    SizedBox(height: 12),
                    ShimmerWidget.rectangular(height: 12, width: 70),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerWidget.rectangular(height: 16, width: 70),
                        ShimmerWidget.circular(width: 28, height: 28),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Complete Merchant / Brand Profile Skeleton Loader
class BrandProfileShimmerLoading extends StatelessWidget {
  const BrandProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const BackButton(color: Color(0xFF121212)),
        title: const ShimmerWidget.rectangular(height: 18, width: 120),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant Hero Header Shimmer
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE8ECEF),
                  width: 1.2,
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      ShimmerWidget.rectangular(
                        width: 56,
                        height: 56,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget.rectangular(height: 18, width: 140),
                            SizedBox(height: 8),
                            ShimmerWidget.rectangular(height: 12, width: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  ShimmerWidget.rectangular(
                    height: 44,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ],
              ),
            ),
            // Tab bar shimmer
            Container(
              height: 48,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: ShimmerWidget.rectangular(height: 16, width: 80),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ShimmerWidget.rectangular(height: 16, width: 80),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Horizontal categories shimmer
            const CategoriesShimmerLoading(),
            const SizedBox(height: 18),
            // Product grid shimmer
            const ProductsShimmerLoading(isHorizontal: false, itemCount: 4),
          ],
        ),
      ),
    );
  }
}



