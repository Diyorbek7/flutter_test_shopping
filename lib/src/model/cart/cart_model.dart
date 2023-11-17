import 'dart:convert';

List<CartUserModel> cartUserModelFromJson(String str) =>
    List<CartUserModel>.from(
        json.decode(str).map((x) => CartUserModel.fromJson(x)));

class CartUserModel {
  final int id;
  final int userId;
  final DateTime date;
  final List<UserProduct> products;
  final int v;

  CartUserModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  CartUserModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<UserProduct>? products,
    int? v,
  }) =>
      CartUserModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        products: products ?? this.products,
        v: v ?? this.v,
      );

  factory CartUserModel.fromJson(Map<String, dynamic> json) => CartUserModel(
        id: json["id"] ?? 0,
        userId: json["userId"] ?? 0,
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        products: json["products"] == null
            ? <UserProduct>[]
            : List<UserProduct>.from(
                json["products"].map((x) => UserProduct.fromJson(x))),
        v: json["__v"] ?? 0,
      );
}

class UserProduct {
  final int productId;
  final int quantity;

  UserProduct({
    required this.productId,
    required this.quantity,
  });

  UserProduct copyWith({
    int? productId,
    int? quantity,
  }) =>
      UserProduct(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory UserProduct.fromJson(Map<String, dynamic> json) => UserProduct(
        productId: json["productId"] ?? 0,
        quantity: json["quantity"] ?? 0,
      );
}
