class HomeGroupModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String webArImage;
  final String phoneArImage;
  final String webEnImage;
  final String phoneEnImage;
  final int? categoryId;
  final int? subCategoryId;
  final int? brandId;
  final int? bundleId;
  final String? categoryName;

  HomeGroupModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.webArImage,
    required this.phoneArImage,
    required this.webEnImage,
    required this.phoneEnImage,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.bundleId,
    this.categoryName,
  });

  factory HomeGroupModel.fromJson(Map<String, dynamic> json) {
    return HomeGroupModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      nameAr: json['name_ar'] ?? json['name_en'] ?? '',
      nameEn: json['name_en'] ?? json['name_ar'] ?? '',
      webArImage: json['web_ar_image'] ?? '',
      phoneArImage: json['phone_ar_image'] ?? json['web_ar_image'] ?? '',
      webEnImage: json['web_en_image'] ?? '',
      phoneEnImage: json['phone_en_image'] ?? json['web_en_image'] ?? '',
      categoryId: json['category_id'] != null ? int.tryParse(json['category_id'].toString()) : null,
      subCategoryId: json['sub_category_id'] != null ? int.tryParse(json['sub_category_id'].toString()) : null,
      brandId: json['brand_id'] != null ? int.tryParse(json['brand_id'].toString()) : null,
      bundleId: json['bundle_id'] != null ? int.tryParse(json['bundle_id'].toString()) : null,
      categoryName: json['category_name'],
    );
  }

  String getImage(String lang) {
    if (lang == 'ar') {
      if (phoneArImage.isNotEmpty) return phoneArImage;
      if (webArImage.isNotEmpty) return webArImage;
    }
    if (phoneEnImage.isNotEmpty) return phoneEnImage;
    if (webEnImage.isNotEmpty) return webEnImage;
    return phoneArImage.isNotEmpty ? phoneArImage : webArImage;
  }

  String getName(String lang) {
    if (lang == 'ar' && nameAr.isNotEmpty) return nameAr;
    return nameEn.isNotEmpty ? nameEn : nameAr;
  }
}

class PaginatedHomeGroupResult {
  final List<HomeGroupModel> items;
  final int totalCount;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  PaginatedHomeGroupResult({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.lastPage,
    required this.hasMore,
  });
}
