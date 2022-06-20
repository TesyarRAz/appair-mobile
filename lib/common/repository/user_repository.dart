import 'package:appair/common/repository/repository.dart';

class UserRepository extends AuthorizedRepository {
  UserRepository({required super.baseUrl});

  Future<Map<String, dynamic>> user() async {
    var response = await get("/user").catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }
  
  Future<Map<String, dynamic>> changePassword(
    String oldPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    var response = await post("/user/change-password", {
      "old_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    }).catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }
}