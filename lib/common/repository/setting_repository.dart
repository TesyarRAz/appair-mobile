import 'package:appair/common/repository/repository.dart';
import 'package:get/get.dart';

class SettingRepository extends Repository with CachedRepository {
  SettingRepository({required super.baseUrl});

  Future<Map<String, dynamic>> settings() {
    return remember("settings-cache", () async {
      var response = await get('/setting').catchError((error) => throw error);

      // Get.log("Setting data : ${response.bodyString}");

      if (response.statusCode == 200) {
        return response.body;
      }

      return null;
    }, () => {});
  }
}
