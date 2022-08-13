import 'package:appair/common/entities/user.dart';
import 'package:dio/dio.dart';
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

  Dio dio() {
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      headers: {
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    ));
  }
}

class AuthorizedRepository extends Repository {
  AuthorizedRepository({required super.baseUrl});

  @override
  void onInit() {
    super.onInit();

    httpClient.addAuthenticator((Request request) async {
      var authToken = Get.find<AuthToken>();

      request.headers['Authorization'] = "Bearer ${authToken.token}";

      return request;
    });
  }

  @override
  Dio dio() {
    return super.dio()
      ..options.headers['Authorization'] =
          "Bearer ${Get.find<AuthToken>().token}";
  }
}

mixin CachedRepository on Repository {
  final _cached = {};

  Future<S> remember<S>(String key, Future<S> Function() create) async {
    if (!_cached.containsKey(key)) {
      _cached[key] = await create();
    }

    return _cached[key];
  }
}
