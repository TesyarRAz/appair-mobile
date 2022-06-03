import 'package:appair/entities/user.dart';
import 'package:appair/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final SharedPreferences preferences;

  AuthService({required this.repository, required this.preferences});

  Future<LoginResponse> login(String username, String password) async {
    var data = await repository.login(username, password);

    if (data.containsKey("token")) {
      return LoginResponse(
        isLoggedIn: true,
        authToken: data['token'],
      );
    }

    return LoginResponse(
      isLoggedIn: false,
    );
  }

  void setLoginToken(String token) {
    preferences.setString("authToken", token);
  }

  void clearLoginToken() {
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