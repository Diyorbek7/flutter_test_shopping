import 'dart:convert';

List<AllUserModel> allUserModelFromJson(String str) => List<AllUserModel>.from(
    json.decode(str).map((x) => AllUserModel.fromJson(x)));

class AllUserModel {
  final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final String phone;
  final int v;

  AllUserModel({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  AllUserModel copyWith({
    Address? address,
    int? id,
    String? email,
    String? username,
    String? password,
    Name? name,
    String? phone,
    int? v,
  }) =>
      AllUserModel(
        address: address ?? this.address,
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        password: password ?? this.password,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        v: v ?? this.v,
      );

  factory AllUserModel.fromJson(Map<String, dynamic> json) => AllUserModel(
        address: json["address"] == null
            ? Address.fromJson({})
            : Address.fromJson(json["address"]),
        id: json["id"] ?? 0,
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        password: json["password"] ?? "",
        name: json["name"] == null
            ? Name.fromJson({})
            : Name.fromJson(json["name"]),
        phone: json["phone"] ?? "",
        v: json["__v"] ?? 0,
      );
}

class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  Address copyWith({
    Geolocation? geolocation,
    String? city,
    String? street,
    int? number,
    String? zipcode,
  }) =>
      Address(
        geolocation: geolocation ?? this.geolocation,
        city: city ?? this.city,
        street: street ?? this.street,
        number: number ?? this.number,
        zipcode: zipcode ?? this.zipcode,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geolocation: json["geolocation"] == null
            ? Geolocation.fromJson({})
            : Geolocation.fromJson(json["geolocation"]),
        city: json["city"] ?? "",
        street: json["street"] ?? "",
        number: json["number"] ?? 0,
        zipcode: json["zipcode"] ?? "",
      );
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({
    required this.lat,
    required this.long,
  });

  Geolocation copyWith({
    String? lat,
    String? long,
  }) =>
      Geolocation(
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
      );
}

class Name {
  final String firstname;
  final String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  Name copyWith({
    String? firstname,
    String? lastname,
  }) =>
      Name(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
      );

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
      );
}
