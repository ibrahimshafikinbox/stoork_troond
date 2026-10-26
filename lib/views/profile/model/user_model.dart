class UserModel {
  final int id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  // final String? address;
  final String? image;
  final String? username;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    // required this.address,
    required this.image,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        // address: json["address"] ?? "",
        image: json["image"] ?? "",
        username: json["username"] ?? "",
      );
}
