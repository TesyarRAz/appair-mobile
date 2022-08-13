import 'package:appair/common/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class AuthRepository extends Repository {
  AuthRepository({required super.baseUrl});

  Future<Either<Map<String, dynamic>?, Map<String, dynamic>?>> login(
      String usernameOrEmail, String password) async {
    var response = await post("/login", <String, dynamic>{
      "username_or_email": usernameOrEmail,
      "password": password,
    });

    Get.log("Response Login : ${response.status.code}");

    if (response.status.code == 200) {
      return Right(response.body);
    }

    if (response.status.code == 401) {
      return Left(response.body);
    }

    return const Left({
      "message": "Terjadi kesalahan",
    });
  }
}
