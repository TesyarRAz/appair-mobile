
import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/screens//profile/data/profile_data.dart';
import 'package:appair/common/service/auth_service.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin<ProfileData> {
  final _transaksiService = Get.find<TransaksiService>();
  final _authService = Get.find<AuthService>();
  final _settingService = Get.find<SettingService>();

  final setting = Setting().obs;

  @override
  void onInit() {
    super.onInit();

    _settingService.settings().then((value) {
      setting.value = value;
    });

    load();
  }

  void load() {
    _transaksiService.history().then((value) {
      if (value != null && value.isNotEmpty) {
        change(
          ProfileData(
            listTransaksiResponse: value,
          ),
          status: RxStatus.success(),
        );
      } else {
        change(null, status: RxStatus.empty());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  Future<bool> logout() async {
    var result = await _authService.logout().catchError((error) => throw error);

    Get.deleteAll(force: true);

    Get.offAndToNamed("/login");

    return result;
  }
}