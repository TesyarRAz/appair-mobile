import 'package:appair/common/service/auth_service.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/common/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userService = Get.find<UserService>();
  final _authService = Get.find<AuthService>();
  final _settingService = Get.find<SettingService>();

  final loadMinimal = const Duration(seconds: 5);

  late AnimationController animationController;
  late Animation<double> iconAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    iconAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(animationController);
  }

  @override
  void onReady() {
    _authService.registerExistsToken();

    if (_authService.hasLoginToken()) {
      debugPrint("Login Token Is Exists By Splash Controller");
      _load();
    } else {
      Future.delayed(loadMinimal, () {
        Get.offAllNamed("/login");
      });
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _load() {
    var time = Stopwatch()..start();

    Future.wait([
      _userService.user(),
      _settingService.settings(),
    ]).then((value) {
      Future.delayed(loadMinimal - time.elapsed, () {
        if (value.isNotEmpty) {
          Get.offAllNamed("/home");
        } else {
          _authService.clearLoginToken();

          Get.offAllNamed("/login");
        }
      });
    })
    .catchError((error) {
      _authService.clearLoginToken();
      Get.offAllNamed("/login");
      // Get.dialog(
      //   barrierDismissible: false,
      //   AlertDialog(
      //     actions: [
      //       TextButton(
      //         child: const Text("Reload"),
      //         onPressed: () {
      //           Get.back();
      //           _load();
      //         },
      //       ),
      //     ],
      //     content: const Text("Terjadi masalah"),
      //   ),
      // );
    });
  }
}
