import 'package:appair/common/entities/user.dart';
import 'package:appair/common/repository/auth_repository.dart';
import 'package:appair/common/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final SharedPreferences preferences;

  AuthService({
    required this.repository,
    required this.preferences,
  });

  Future<LoginResponse> login(String username, String password) async {
    var data = await repository.login(username, password);

    var dataSuccess = data.getOrElse(() => {});
    var dataFail = data.getOrElse(() => {});

    if (dataSuccess?.containsKey("token") ?? false) {
      setLoginToken(dataSuccess!["token"]);

      return LoginResponse(
        isLoggedIn: true,
        authToken: dataSuccess['token'],
      );
    }

    return LoginResponse(
      isLoggedIn: false,
      dataFail: dataFail,
    );
  }

  Future<bool> logout() async {
    clearLoginToken();
    Get.delete<User>();

    return true;
  }

  void registerExistsToken({ bool register = false}) {
    if (hasLoginToken()) {
      setLoginToken(getLoginToken()!, register: register);
    }

    debugPrint("Prefs Auth Token Exists : ${hasLoginToken()}");
    debugPrint("Auth Token Exists : ${Get.isRegistered<AuthToken>()}");
  }

  void setLoginToken(String token, {bool register = true}) {
    Get.put(AuthToken(token: token));

    if (register) {
      preferences.setString("authToken", token);
    }
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
  final Map<String, dynamic>? dataFail;

  LoginResponse({
    required this.isLoggedIn,
    this.authToken,
    this.dataFail,
  });
}
