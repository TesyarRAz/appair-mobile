import 'package:appair/repository/repository.dart';

class AuthRepository extends Repository {
  AuthRepository({required super.baseUrl});

  Future<Map<String, dynamic>> login(String usernameOrEmail, String password) async {
    var response = await post("/login", <String, dynamic>{
      "username_or_email": usernameOrEmail,
      "password": password,
    });

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }
}
