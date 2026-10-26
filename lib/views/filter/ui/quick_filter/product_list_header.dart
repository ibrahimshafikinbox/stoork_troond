import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/filter/ui/quick_filter/product_filter_bottom_sheet.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class ProductListHeader extends StatelessWidget {
  const ProductListHeader({
    super.key,
    required this.productController,
    this.totalCount,
  });

  final ProductController productController;
  final int? totalCount;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    final isFilterActive = productController.isFilterActive;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          // 1. Grid/List View Toggle Button (Start)
          InkWell(
            onTap: productController.changeView,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColor.cFFF0D5,
                border: Border.all(color: AppColor.main),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  productController.isGridView
                      ? BootstrapIcons.list_ul
                      : BootstrapIcons.grid,
                  size: 18,
                  color: AppColor.c3D3D3D,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // 2. Filter Button (Center - Expanded for largest tap area)
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const ProductFilterBottomSheet(),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isFilterActive ? AppColor.main : AppColor.cFAFAFA,
                  border: Border.all(
                    color: isFilterActive ? AppColor.main : AppColor.cDFDFDF,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      BootstrapIcons.sliders,
                      size: 16,
                      color: isFilterActive ? Colors.white : AppColor.c717171,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      local.filter,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isFilterActive ? Colors.white : AppColor.c121212,
                      ),
                    ),
                    if (isFilterActive) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // 3. Total Count Badge (End)
          if (totalCount != null && totalCount! > 0) ...[
            const SizedBox(width: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.main.withValues(alpha: 0.08),
                border: Border.all(
                  color: AppColor.main.withValues(alpha: 0.25),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$totalCount",
                    style: const TextStyle(
                      color: AppColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "منتج",
                    style: TextStyle(
                      color: AppColor.c121212,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Reset Filter Button if Active
          if (isFilterActive) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: productController.resetFilters,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
