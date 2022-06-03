import 'package:appair/repository/repository.dart';

class UserRepository extends AuthorizedRepository {
  UserRepository({required super.baseUrl, required super.authToken});

  Future<Map<String, dynamic>> user() async {
    var response = await get("/user").catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }
}