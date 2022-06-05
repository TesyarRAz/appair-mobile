import 'package:appair/repository/repository.dart';

class SettingRepository extends Repository {
  SettingRepository({required super.baseUrl});

  Future<Map<String, dynamic>> settings() async {
    var response = await get('/setting').catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }
}