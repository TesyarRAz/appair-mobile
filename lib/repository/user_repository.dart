import 'package:appair/entities/user.dart';
import 'package:appair/repository/repository.dart';
import 'package:flutter/material.dart';

class UserRepository extends AuthorizedRepository {
  UserRepository({required super.baseUrl, required super.userToken});

  Future<User?> userInfo() async {
    var response = await get("/user");

    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }

    return null;
  }
}