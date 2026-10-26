// class ParentCategory {
//     final int id;
//     final String name;
//     final String description;
//     final String image;
//     final String icon;
//     // final List<ParentCategory> children;

//     ParentCategory({
//         required this.id,
//         required this.name,
//         required this.description,
//         required this.image,
//         required this.icon,
//         // required this.children,
//     });

//     factory ParentCategory.fromJson(Map<String, dynamic> json) => ParentCategory(
//         id: json["id"],
//         name: json["name"] ??'',
//         description: json["description"] ??"",
//         image: json["image"] ?? "" ,
//         icon: json["icon"] ?? "",
//         // children: List<ParentCategory>.from(json["children"].map((x) => ParentCategory.fromJson(x))),
//     );

// }
