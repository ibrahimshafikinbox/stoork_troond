// class FavModel {
//   final int id;
//   final String name;
//   final String description;
//   final bool status;
//   final int stockCount;
//   final ImageModel image;
//   final int rating;
//   final Price price;

//   FavModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.status,
//     required this.stockCount,
//     required this.image,
//     required this.rating,
//     required this.price,
//   });

//   factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         status: json["status"],
//         stockCount: json["stock_count"],
//         image: ImageModel.fromJson(json["image"]),
//         rating: json["rating"],
//         price: Price.fromJson(json["price"]),
//       );
// }

// class ImageModel {
//   final int id;
//   final String path;
//   final int order;
//   final int isMain;

//   ImageModel({
//     required this.id,
//     required this.path,
//     required this.order,
//     required this.isMain,
//   });

//   factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
//         id: json["id"],
//         path: json["path"],
//         order: json["order"],
//         isMain: json["is_main"],
//       );
// }

// class Price {
//   final int id;
//   final int min;
//   final int max;
//   final int price;
//   final int order;

//   Price({
//     required this.id,
//     required this.min,
//     required this.max,
//     required this.price,
//     required this.order,
//   });

//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         id: json["id"],
//         min: json["min"],
//         max: json["max"],
//         price: json["price"],
//         order: json["order"],
//       );
// }