import 'package:appair/common/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepository extends Repository {
  AuthRepository({required super.baseUrl});

  Future<Either<Map<String, dynamic>?, Map<String, dynamic>?>> login(String usernameOrEmail, String password) async {
    var response = await post("/login", <String, dynamic>{
      "username_or_email": usernameOrEmail,
      "password": password,
    });

    if (response.statusCode == 200) {
      return Right(response.body);
    }

    return Left(response.body);
  }
}
