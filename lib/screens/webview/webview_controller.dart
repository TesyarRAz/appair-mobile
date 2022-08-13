import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:get/get.dart';

class WebViewController extends GetxController {
  final settingService = Get.find<SettingService>();

  final setting = Setting().obs;

  @override
  void onInit() {
    super.onInit();

    settingService.settings().then((value) {
      setting.value = value;
    });
  }
}