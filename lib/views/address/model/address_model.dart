class AddressModel {
  final int id;
  String type;
    String phone;
  String mainAdress;
  String state;
  String city;
  bool isDefault;

  AddressModel({
    required this.id,
    required this.type,
    required this.mainAdress,
    required this.state,
    required this.city,
    required this.isDefault,
    required this.phone,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        type: json["type"] ?? "",
        mainAdress: json["main_adress"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        isDefault: json["is_default"] ?? "",
        phone: json["phone"] ?? "",
      );
}
