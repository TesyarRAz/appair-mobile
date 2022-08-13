import 'package:appair/common/repository/repository.dart';

class SettingRepository extends Repository with CachedRepository {
  SettingRepository({required super.baseUrl});

  Future<Map<String, dynamic>> settings() {
    return remember("settings", () async {
      var response = await get('/setting').catchError((error) => throw error);

      if (response.statusCode == 200) {
        return response.body;
      }

      return {};
    });
  }
}