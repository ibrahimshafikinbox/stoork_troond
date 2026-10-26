class CitiesModel {
    final String governorate;
    final List<String> cities;

    CitiesModel({
        required this.governorate,
        required this.cities,
    });

    factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        governorate: json["governorate"],
        cities: List<String>.from(json["cities"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "governorate": governorate,
        "cities": List<dynamic>.from(cities.map((x) => x)),
    };
}
