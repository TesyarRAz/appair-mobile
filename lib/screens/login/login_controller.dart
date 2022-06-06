import 'package:appair/service/auth_service.dart';
import 'package:appair/service/user_service.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();

  void login(String username, String password) async {
    var loginResponse = await Get.showOverlay(
      asyncFunction: () =>
          _authService.login(username, password).catchError((error) => throw error),
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
    )
    .catchError((error) {
      debugPrint(error.toString());

      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi masalah saat login",
        duration: Duration(seconds: 2),
      ));
    });

    if (loginResponse.isLoggedIn) {
      await _userService.user();

      Get.offAllNamed('/home');
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Username atau password salah",
        duration: Duration(seconds: 2),
      ));
    }
  }
}
