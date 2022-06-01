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

class UserToken {
  String? token;

  UserToken({
    this.token,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
    token: json["token"],
  );
}