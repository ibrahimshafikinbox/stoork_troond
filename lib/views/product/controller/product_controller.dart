import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';

class ProductController extends ChangeNotifier {
  bool isGridView = true;

  void changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  // Filter & Sort States
  double? minPrice;
  double? maxPrice;
  int? selectedCategoryId;
  int? selectedBrandId;
  String? sortBy; // 'price_asc', 'price_desc', 'rating', 'newest'

  bool get isFilterActive =>
      minPrice != null ||
      maxPrice != null ||
      selectedCategoryId != null ||
      selectedBrandId != null ||
      sortBy != null;

  void applyFilters({
    double? minP,
    double? maxP,
    int? categoryId,
    int? brandId,
    String? sort,
  }) {
    minPrice = minP;
    maxPrice = maxP;
    selectedCategoryId = categoryId;
    selectedBrandId = brandId;
    sortBy = sort;
    notifyListeners();
  }

  void resetFilters() {
    minPrice = null;
    maxPrice = null;
    selectedCategoryId = null;
    selectedBrandId = null;
    sortBy = null;
    notifyListeners();
  }

  List<ProductPreview> filterProductList(List<ProductPreview> originalList) {
    if (originalList.isEmpty) return [];

    List<ProductPreview> filtered = List.from(originalList);

    // Min price filter
    if (minPrice != null) {
      filtered = filtered.where((p) => p.price >= minPrice!).toList();
    }

    // Max price filter
    if (maxPrice != null) {
      filtered = filtered.where((p) => p.price <= maxPrice!).toList();
    }

    // Category filter
    if (selectedCategoryId != null) {
      filtered = filtered
          .where((p) => p.category != null && p.category!.id == selectedCategoryId)
          .toList();
    }

    // Brand filter
    if (selectedBrandId != null) {
      filtered = filtered
          .where((p) => p.brand != null && p.brand!.id == selectedBrandId)
          .toList();
    }

    // Sort
    if (sortBy != null) {
      switch (sortBy) {
        case 'price_asc':
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_desc':
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'rating':
          filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
          break;
        case 'newest':
          filtered.sort((a, b) => b.id.compareTo(a.id));
          break;
      }
    }

    return filtered;
  }
}
