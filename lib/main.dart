import 'dart:convert';

import 'package:appair/entities/user.dart';
import 'package:appair/repository/auth_repository.dart';
import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:appair/screens/home/home_page.dart';
import 'package:appair/screens/list_transaksi/list_transaksi_page.dart';
import 'package:appair/screens/login_page.dart';
import 'package:appair/screens/profile/profile_page.dart';
import 'package:appair/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  var env = await rootBundle.loadStructuredData(
    "environment.json",
    (value) async => await jsonDecode(value),
  );

  Get.put(await PackageInfo.fromPlatform());

  var prefs = Get.put(await SharedPreferences.getInstance());

  var userToken = Get.put(UserToken(token: prefs.getString("userToken")));

  Get.put(AuthRepository(
    baseUrl: env['baseUrl'],
  ));

  Get.put(UserRepository(
    baseUrl: env['baseUrl'],
    userToken: userToken,
  ));

  Get.put(InfoRepository(
    baseUrl: env['baseUrl'],
  ));

  Get.put(TransaksiRepository(
    baseUrl: env['baseUrl'],
    userToken: userToken,
  ));

  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        cardColor: Colors.white,
      ),
      getPages: [
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/home", page: () => const HomePage()),
        GetPage(name: "/profile", page: () => const ProfilePage(), transition: Transition.rightToLeft),
        GetPage(name: "/list/transaksi", page: () => const ListTransaksiPage(), transition: Transition.rightToLeft),
      ],
    );
  }
}
