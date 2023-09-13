// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<HomeProductModel> homeProductModelFromJson(String str) =>
    List<HomeProductModel>.from(
        json.decode(str).map((x) => HomeProductModel.fromJson(x)));

class HomeProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final String image;
  final Rating rating;
  bool like;
  int priceCount;

  HomeProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.like = false,
    this.priceCount = 0,
  });

  HomeProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    Category? category,
    String? image,
    Rating? rating,
    bool? like,
    int? priceCount,
  }) =>
      HomeProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        like: like ?? this.like,
        priceCount: priceCount ?? this.priceCount,
      );

  factory HomeProductModel.fromJson(Map<String, dynamic> json) =>
      HomeProductModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        price: json["price"]?.toDouble() ?? 0.0,
        description: json["description"] ?? "",
        category: json["category"] == null
            ? categoryValues.map[[]]!
            : categoryValues.map[json["category"]]!,
        image: json["image"] ?? "",
        rating: json["rating"] == null
            ? Rating.fromJson({})
            : Rating.fromJson(json["rating"]),
        like: json["like"] ?? false,
        priceCount: json["priceCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "image": image,
        "like": like,
      };
}

enum Category { ELECTRONICS, JEWELERY, MEN_S_CLOTHING, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) =>
      Rating(
        rate: rate ?? this.rate,
        count: count ?? this.count,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble() ?? 0.0,
        count: json["count"] ?? 0,
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
