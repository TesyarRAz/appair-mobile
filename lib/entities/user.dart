import 'package:appair/entities/customer.dart';

class User {
  int? id;
  String? name;
  String? email;
  Customer? customer;

  User({
    this.id,
    this.name,
    this.email,
    this.customer,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "customer": customer?.toJson(),
  };
}

class AuthToken {
  String? token;

  AuthToken({
    this.token,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    token: json["token"],
  );
}