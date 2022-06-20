import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/repository/setting_repository.dart';
import 'package:get/get.dart';

class SettingService extends GetxService {
  final SettingRepository repository;
  
  SettingService({required this.repository});

  Future<Setting> settings() async {
    var data = await repository.settings();

    return Setting.fromJson(data);
  }
}