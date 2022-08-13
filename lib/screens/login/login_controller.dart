import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/service/auth_service.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/common/service/user_service.dart';
import 'package:appair/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();
  final _settingService = Get.find<SettingService>();

  final setting = Setting().obs;

  @override
  void onInit() {
    super.onInit();

    _settingService.settings().then((value) {
      setting.value = value;
    });
  }

  void login(String username, String password) async {
    var loginResponse = await Get.showOverlay(
      asyncFunction: () => _authService.login(username, password),
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
      Get.log("LoginError : ${error.toString()}");

      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi masalah saat login",
        duration: Duration(seconds: 2),
      ));
    });

    if (loginResponse.isLoggedIn) {
      await _userService.user();

      Get.offAllNamed('/home');
    } else {
      Get.log("Login Data Fail : ${loginResponse.dataFail.toString()}");

      Get.showSnackbar(GetSnackBar(
        message: (loginResponse.dataFail?.containsKey("message") ?? false)
            ? loginResponse.dataFail!['message']
            : "Username atau password salah",
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
