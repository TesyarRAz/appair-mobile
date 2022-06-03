import 'package:appair/entities/user.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:appair/service/auth_service.dart';
import 'package:appair/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userService = Get.find<UserService>();
  final _authService = Get.find<AuthService>();

  final loadMinimal = const Duration(seconds: 5);

  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);

    if (_authService.hasLoginToken()) {
      _load();
    } else {
      Future.delayed(loadMinimal, () {
        Get.offAndToNamed("/login");
      });
    }
  }

  void _load() {
    var time = Stopwatch()..start();
    _userService.user().then((value) {
      Future.delayed(loadMinimal - time.elapsed, () {
        if (value != null) {
          Get.put(value);

          Get.offAndToNamed("/home");
        } else {
          _authService.clearLoginToken();

          Get.offAndToNamed("/login");
        }
      });
    }).catchError((error) {
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          actions: [
            TextButton(
              child: const Text("Reload"),
              onPressed: () {
                Get.back();
                _load();
              },
            ),
          ],
          content: const Text("Terjadi masalah"),
        ),
      );
    });
  }
}

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeInOut,
          ),
          child: const Icon(
            Icons.water,
            size: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
