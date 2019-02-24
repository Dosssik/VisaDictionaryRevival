import 'dart:convert';

Country countryFromJson(String str) {
  final jsonData = json.decode(str);
  return Country.fromJson(jsonData);
}

String countryToJson(Country data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Country {

  static final tableName = "countries";

  int id;
  String countryName;
  String flag;

  Country({
    this.id,
    this.countryName,
    this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => new Country(
    id: json["id"],
    countryName: json["name"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryName": countryName,
    "flag": flag,
  };
}