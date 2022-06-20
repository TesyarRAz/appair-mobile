import 'package:appair/common/entities/user.dart';
import 'package:appair/common/repository/user_repository.dart';
import 'package:appair/screens//splash/splash_controller.dart';
import 'package:appair/common/service/auth_service.dart';
import 'package:appair/common/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller.iconAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.iconAnimation.value,
              child: child,
            );
          },
          child: const Icon(
            Icons.water,
            size: 100,
            color: Colors.blue,
          ),
        )
      ),
    );
  }
}
