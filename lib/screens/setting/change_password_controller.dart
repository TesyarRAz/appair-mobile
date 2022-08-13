import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/common/service/user_service.dart';
import 'package:appair/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final settingService = Get.find<SettingService>();
  final userService = Get.find<UserService>();

  final setting = Setting().obs;

  @override
  void onInit() {
    super.onInit();

    settingService.settings().then((value) {
      setting.value = value;
    });
  }

  void changePassword(
    String oldPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    var success = await Get.showOverlay(
      asyncFunction: () => userService.changePassword(
          oldPassword, newPassword, newPasswordConfirmation),
      loadingWidget: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: LoadingWidget(),
          ),
        ),
      ),
    ).catchError((error) {
      debugPrint(error.toString());

      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi masalah saat login",
        duration: Duration(seconds: 2),
      ));
    });

    if (success) {
      Get.back();

      Get.showSnackbar(const GetSnackBar(
        message: "Password berhasil diubah",
        duration: Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Gagal mengubah password",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    }
  }
}
