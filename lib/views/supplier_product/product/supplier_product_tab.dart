import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/supplier_product/controller/supplier_product_controller.dart';
import 'package:troond/views/supplier_product/services/supplier_product_services.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../config/app_const/shared_const.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../widget/input/build_input.dart';

class SupplierProductsTab extends StatelessWidget {
  const SupplierProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    SupplierProductController controller =
        Provider.of<SupplierProductController>(context);
    bool isSearch = controller.searchText.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: FutureBuilder<List<ProductPreview>>(
        future: SupplierProductServices().getProdcuts(),
        builder: (context, snapshot) {
          var cache = SharedPref.getKey(
            key: SharedConsts.supplierProducts,
          );
          if (cache == null && !snapshot.hasData) {
            return const LoadingWidget();
          } else {
            List<ProductPreview> products = [];
            if (cache != null) {
              try {
                var json = jsonDecode(cache);
                for (var element in json["data"]) {
                  products.add(ProductPreview.fromJson(element));
                }
              } catch (_) {}
            }
            var data = isSearch
                ? controller.products
                : snapshot.hasData
                    ? snapshot.data!
                    : products;

            return CustomScrollView(
              slivers: [
                //* ─── Branded App Bar ───
                SliverAppBar(
                  expandedHeight: 130,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColor.main,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add_rounded,
                            color: Colors.white, size: 20),
                      ),
                      onPressed: () {
                        controller.navEdit(context: context, id: 0);
                      },
                    ),
                    const SizedBox(width: 4),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF6801),
                            Color(0xFFFF8A3D),
                            Color(0xFFFF6801),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      BootstrapIcons.box_seam,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          local.product,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${data.length} ${local.product}',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //* ─── Search Bar ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: BuildInput(
                        hintText: local.search,
                        controller: controller.searchText,
                        iconButton: Icon(
                          BootstrapIcons.search,
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                        onChange: (value) {
                          if (snapshot.hasData) {
                            controller.search(snapshot.data!);
                          }
                        },
                      ),
                    ),
                  ),
                ),

                //* ─── Products Count Badge ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColor.main.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${data.length}',
                            style: const TextStyle(
                              color: AppColor.main,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          local.product,
                          style: const TextStyle(
                            color: AppColor.c717171,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //* ─── Products Grid / Empty ───
                if (data.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColor.main.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              BootstrapIcons.box_seam,
                              size: 48,
                              color: AppColor.main,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'لا يوجد منتجات بعد',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColor.c3D3D3D,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'ابدأ بإضافة منتجاتك الآن',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.navEdit(context: context, id: 0);
                            },
                            icon: const Icon(Icons.add, size: 20),
                            label: Text(local.product),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.main,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final product = data[i];
                          return _ProductCard(
                            product: product,
                            controller: controller,
                            local: local,
                          );
                        },
                        childCount: data.length,
                      ),
                    ),
                  ),

                //* Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

/// ─── Modern Product Card Widget ───
class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.controller,
    required this.local,
  });

  final ProductPreview product;
  final SupplierProductController controller;
  final dynamic local;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        product.images.isNotEmpty && product.images[0].path.isNotEmpty;
    final hasDiscount =
        product.discount.isNotEmpty && product.discount != "0";
    final inStock = product.stockCount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPreviewScreen,
              arguments: product.id,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* ── Image ──
                Hero(
                  tag: 'product_${product.id}',
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 90,
                          height: 90,
                          child: hasImage
                              ? CachedNetworkImage(
                                  imageUrl: product.images[0].path,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: const Color(0xFFF2F3F7),
                                    child: const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColor.main,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: const Color(0xFFF2F3F7),
                                    child: const Icon(
                                      BootstrapIcons.image,
                                      color: AppColor.cB8B8B8,
                                      size: 28,
                                    ),
                                  ),
                                )
                              : Container(
                                  color: const Color(0xFFF2F3F7),
                                  child: const Icon(
                                    BootstrapIcons.box,
                                    color: AppColor.cB8B8B8,
                                    size: 28,
                                  ),
                                ),
                        ),
                      ),
                      //* Discount badge
                      if (hasDiscount)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFD21318),
                                  Color(0xFFFA4040),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '-${product.discount}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                //* ── Details ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Name
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColor.c1E1E1E,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),

                      //* Category & Brand Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          // if (product.category != null &&
                          //     product.category!.name.isNotEmpty)
                          //   _buildTag(
                          //     product.category!.name,
                          //     AppColor.main.withOpacity(0.1),
                          //     AppColor.main,
                          //   ),
                          if (product.brand != null &&
                              product.brand!.name.isNotEmpty)
                            _buildTag(
                              product.brand!.name,
                              const Color(0xFF29296E).withOpacity(0.08),
                              const Color(0xFF29296E),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //* Price & Stock
                      Row(
                        children: [
                          //* Price
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38AE04).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${product.price} ${AppStrings.currecy}',
                              style: const TextStyle(
                                color: Color(0xFF38AE04),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          //* Stock indicator
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: inStock
                                  ? const Color(0xFF38AE04).withOpacity(0.08)
                                  : const Color(0xFFFA4040).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  inStock
                                      ? Icons.check_circle_rounded
                                      : Icons.error_rounded,
                                  size: 12,
                                  color: inStock
                                      ? const Color(0xFF38AE04)
                                      : const Color(0xFFFA4040),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product.stockCount}',
                                  style: TextStyle(
                                    color: inStock
                                        ? const Color(0xFF38AE04)
                                        : const Color(0xFFFA4040),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          //* Actions Menu
                          PopupMenuButton(
                            padding: EdgeInsets.zero,
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F3F7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.more_horiz_rounded,
                                color: AppColor.c717171,
                                size: 18,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 6,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: SupplierProductActions(
                                    id: product.id,
                                    controller: controller,
                                  ),
                                ),
                              ];
                            },
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
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// ─── Product Action Buttons ───
class SupplierProductActions extends StatelessWidget {
  const SupplierProductActions({
    super.key,
    required this.id,
    required this.controller,
  });
  final int id;
  final SupplierProductController controller;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Column(
      children: [
        _buildAction(
          icon: Icons.visibility_outlined,
          iconColor: AppColor.main,
          label: local.viewProduct,
          labelColor: AppColor.c3D3D3D,
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(
              AppRoutes.productPreviewScreen,
              arguments: id,
            );
          },
        ),
        const Divider(height: 16, color: AppColor.cF1F1F1),
        _buildAction(
          iconWidget: const SvgWidget(svgName: "edit.svg"),
          label: local.editProduct,
          labelColor: AppColor.c3D3D3D,
          onTap: () {
            Navigator.of(context).pop();
            controller.navEdit(context: context, id: id);
          },
        ),
        const Divider(height: 16, color: AppColor.cF1F1F1),
        _buildAction(
          iconWidget: const SvgWidget(svgName: "trash_red.svg"),
          label: local.remove,
          labelColor: AppColor.cFA4040,
          onTap: () {
            Navigator.of(context).pop();
            controller.deleteProduct(id, context);
          },
        ),
      ],
    );
  }

  Widget _buildAction({
    IconData? icon,
    Color? iconColor,
    Widget? iconWidget,
    required String label,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            if (iconWidget != null)
              iconWidget
            else
              Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
