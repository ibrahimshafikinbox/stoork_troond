import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/product/controller/product_controller.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  const ProductFilterBottomSheet({super.key});

  @override
  State<ProductFilterBottomSheet> createState() =>
      _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  String? selectedSortBy;

  @override
  void initState() {
    super.initState();
    final controller = context.read<ProductController>();
    minPriceController = TextEditingController(
      text: controller.minPrice != null
          ? controller.minPrice!.toInt().toString()
          : '',
    );
    maxPriceController = TextEditingController(
      text: controller.maxPrice != null
          ? controller.maxPrice!.toInt().toString()
          : '',
    );
    selectedSortBy = controller.sortBy;
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();
    var local = MyLocalizations.getLocal(context);

    return Container(
      padding: EdgeInsetsDirectional.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        start: 20,
        end: 20,
        top: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.filter,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c121212,
                ),
              ),
              Row(
                children: [
                  if (controller.isFilterActive)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          minPriceController.clear();
                          maxPriceController.clear();
                          selectedSortBy = null;
                        });
                        controller.resetFilters();
                        Navigator.pop(context);
                      },
                      child: Text(
                        local.reset,
                        style: const TextStyle(
                          color: AppColor.cD21318,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColor.c717171),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Price Filter Section
          Text(
            "${local.price} (${AppStrings.currecy})",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColor.c121212,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: local.min,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.main),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: local.max,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.main),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sort Section
          Text(
            local.sortingBy,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColor.c121212,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSortChip(local.lowToHigh, "price_asc"),
              _buildSortChip(local.highToLow, "price_desc"),
              _buildSortChip(local.bestRated, "rating"),
              _buildSortChip(local.newArrivais, "newest"),
            ],
          ),
          const SizedBox(height: 24),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                double? minP = double.tryParse(minPriceController.text.trim());
                double? maxP = double.tryParse(maxPriceController.text.trim());

                controller.applyFilters(
                  minP: minP,
                  maxP: maxP,
                  sort: selectedSortBy,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.main,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                local.apply,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = selectedSortBy == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColor.main.withValues(alpha: 0.15),
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(
        color: isSelected ? AppColor.main : AppColor.c121212,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected ? AppColor.main : Colors.grey.shade300,
      ),
      onSelected: (selected) {
        setState(() {
          selectedSortBy = selected ? value : null;
        });
      },
    );
  }
}
