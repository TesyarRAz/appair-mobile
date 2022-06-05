import 'package:appair/entities/user.dart';
import 'package:appair/repository/auth_repository.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final UserRepository userRepository;
  final SharedPreferences preferences;

  AuthService({
    required this.repository,
    required this.preferences,
    required this.userRepository,
  });

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();

    if (hasLoginToken()) {
      setLoginToken(getLoginToken()!, register: false);
    }
  }

  Future<LoginResponse> login(String username, String password) async {
    var data = await repository.login(username, password);

    if (data.containsKey("token")) {
      setLoginToken(data["token"]);

      return LoginResponse(
        isLoggedIn: true,
        authToken: data['token'],
      );
    }

    return LoginResponse(
      isLoggedIn: false,
    );
  }

  Future<void> setLoginToken(String token, {bool register = true}) {
    Get.put(AuthToken(token: token));

    if (register) {
      preferences.setString("authToken", token);
    }

    return userRepository.user().then((user) {
      Get.put(user);
    });
  }

  void clearLoginToken() {
    Get.delete<AuthToken>();

    preferences.remove("authToken");
  }

  String? getLoginToken() {
    return preferences.getString("authToken");
  }

  bool hasLoginToken() {
    return preferences.containsKey("authToken");
  }
}

class LoginResponse {
  final bool isLoggedIn;
  final String? authToken;

  LoginResponse({
    required this.isLoggedIn,
    this.authToken,
  });
}
