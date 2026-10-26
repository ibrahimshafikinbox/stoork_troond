import 'package:troond/data/shared_pref/shared_pref.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? nameAr;
  final String? nameEn;
  final String description;
  final String image;
  final String icon;
  final List<CategoryModel> children;
  bool isFilter;
  final CategoryModel? parent;

  CategoryModel({
    required this.id,
    required this.name,
    this.nameAr,
    this.nameEn,
    required this.description,
    required this.image,
    required this.icon,
    required this.children,
    required this.isFilter,
    required this.parent,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String currentLang = SharedPref.getLanguage();

    String rawNameAr = (json["name_ar"] ?? json["title_ar"] ?? json["nameAr"] ?? "").toString().trim();
    String rawNameEn = (json["name_en"] ?? json["title_en"] ?? json["nameEn"] ?? "").toString().trim();
    String rawNameGeneral = (json["name"] ?? json["title"] ?? json["category_name"] ?? "").toString().trim();

    String displayName = "";
    if (currentLang == 'en') {
      if (rawNameEn.isNotEmpty) {
        displayName = rawNameEn;
      } else if (rawNameGeneral.isNotEmpty) {
        displayName = rawNameGeneral;
      } else {
        displayName = rawNameAr;
      }
    } else {
      if (rawNameAr.isNotEmpty) {
        displayName = rawNameAr;
      } else if (rawNameGeneral.isNotEmpty) {
        displayName = rawNameGeneral;
      } else {
        displayName = rawNameEn;
      }
    }

    return CategoryModel(
      id: json["id"] ?? json["category_id"] ?? 0,
      name: displayName,
      nameAr: rawNameAr.isNotEmpty ? rawNameAr : null,
      nameEn: rawNameEn.isNotEmpty ? rawNameEn : null,
      description: (json["description"] ?? json["description_ar"] ?? json["description_en"] ?? "").toString(),
      image: (json["image"] ?? json["icon"] ?? "").toString(),
      icon: (json["icon"] ?? json["image"] ?? "").toString(),
      isFilter: json["isFilter"] ?? false,
      parent: json["parent"] == null ? null : CategoryModel.fromJson(json["parent"]),
      children: json["children"] == null
          ? []
          : List<CategoryModel>.from(
              (json["children"] as List).map((x) => CategoryModel.fromJson(x))),
    );
  }
}
