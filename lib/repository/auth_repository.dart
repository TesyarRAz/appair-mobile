import 'package:appair/entities/user.dart';
import 'package:appair/repository/repository.dart';
import 'package:get/get_connect/connect.dart';

class LoginResponse {
  final bool isLoggedIn;
  final UserToken? userToken;

  LoginResponse({
    required this.isLoggedIn,
    required this.userToken,
  });
}

class AuthRepository extends Repository {
  AuthRepository({required super.baseUrl});

  Future<LoginResponse> login(String usernameOrEmail, String password) async {
    var response = await post("/login", <String, dynamic>{
      "username_or_email": usernameOrEmail,
      "password": password,
    });

    if (response.statusCode == 200) {
      return LoginResponse(
        isLoggedIn: true,
        userToken: UserToken.fromJson(response.body),
      );
    }

    return LoginResponse(
      isLoggedIn: false,
      userToken: null,
    );
  }
}
