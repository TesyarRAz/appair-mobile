import 'package:appair/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Repository extends GetConnect {
  Repository({
    required String baseUrl,
  }) {
    this.baseUrl = baseUrl;
  }

  @override
  void onInit() {
    httpClient.addRequestModifier((Request request) async {
      request.headers['Accept'] = 'application/json';

      return request;
    });
  }
}

class AuthorizedRepository extends Repository {
  final AuthToken authToken;

  AuthorizedRepository({required super.baseUrl, required this.authToken});

  @override
  void onInit() {
    super.onInit();

    httpClient.addAuthenticator((Request request) async {
      request.headers['Authorization'] = "Bearer ${authToken.token}";

      return request;
    });
  }
}