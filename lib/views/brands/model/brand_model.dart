import 'package:troond/data/shared_pref/shared_pref.dart';

class BrandModel {
  final int id;
  final String name;
  final String description;
  final String logo;
  final String color;
  final String image;
  bool isFilter;

  BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.color,
    required this.image,
    required this.isFilter,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    String currentLang = SharedPref.getLanguage();

    String rawNameAr = (json["name_ar"] ?? json["title_ar"] ?? json["nameAr"] ?? "").toString().trim();
    String rawNameEn = (json["name_en"] ?? json["title_en"] ?? json["nameEn"] ?? "").toString().trim();
    String rawNameGeneral = (json["name"] ?? json["title"] ?? json["brand_name"] ?? "").toString().trim();

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

    String rawDescAr = (json["description_ar"] ?? json["desc_ar"] ?? "").toString().trim();
    String rawDescEn = (json["description_en"] ?? json["desc_en"] ?? "").toString().trim();
    String rawDescGen = (json["description"] ?? "").toString().trim();

    String displayDesc = "";
    if (currentLang == 'en') {
      displayDesc = rawDescEn.isNotEmpty
          ? rawDescEn
          : (rawDescGen.isNotEmpty ? rawDescGen : rawDescAr);
    } else {
      displayDesc = rawDescAr.isNotEmpty
          ? rawDescAr
          : (rawDescGen.isNotEmpty ? rawDescGen : rawDescEn);
    }

    return BrandModel(
      id: json["id"] ?? json["brand_id"] ?? 0,
      name: displayName,
      description: displayDesc,
      logo: json["logo"] ?? json["image"] ?? "",
      color: json["color"] ?? "",
      image: json["image"] ?? json["logo"] ?? "",
      isFilter: json["isFilter"] ?? false,
    );
  }
}
