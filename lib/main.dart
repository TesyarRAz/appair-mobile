import 'dart:convert';

import 'package:appair/repository/auth_repository.dart';
import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/setting_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:appair/screens/bayar/bayar_controller.dart';
import 'package:appair/screens/bayar/bayar_page.dart';
import 'package:appair/screens/home/home_controller.dart';
import 'package:appair/screens/home/home_page.dart';
import 'package:appair/screens/login_page.dart';
import 'package:appair/screens/profile/profile_page.dart';
import 'package:appair/screens/splash_page.dart';
import 'package:appair/service/auth_service.dart';
import 'package:appair/service/info_service.dart';
import 'package:appair/service/setting_service.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:appair/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_info/platform_info.dart';
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

  var preferences = Get.put(await SharedPreferences.getInstance());

  // Initialize Repository First
  var transaksiRepository = Get.put(
    TransaksiRepository(
      baseUrl: env['baseUrl'],
    ),
  );

  var infoRepository = Get.put(
    InfoRepository(
      baseUrl: env['baseUrl'],
    ),
  );

  var userRepository = Get.put(
    UserRepository(
      baseUrl: env['baseUrl'],
    ),
  );

  var authRepository = Get.put(
    AuthRepository(
      baseUrl: env['baseUrl'],
    ),
  );

  var settingRepository = Get.put(
    SettingRepository(
      baseUrl: env['baseUrl'],
    ),
  );

  // Initialize Service
  Get.put(
    AuthService(
      repository: authRepository,
      userRepository: userRepository,
      preferences: preferences,
    ), 
  );

  Get.put(
    TransaksiService(
      repository: transaksiRepository,
    ),
  );

  Get.put(
    InfoService(
      repository: infoRepository,
    ),
  );

  Get.put(
    UserService(
      repository: userRepository,
    ),
  );

  Get.put(
    SettingService(
      repository: settingRepository,
    ),
  );

  Get.lazyPut(() => SplashController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => BayarController(), fenix: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('id', 'ID'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 23,
            fontFamily: "Ubuntu",
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black87,
          ),
          foregroundColor: Colors.black,
        ),
      ),
      home: const SplashPage(),
      getPages: [
        GetPage(
          name: "/login",
          page: () => const LoginPage(),
        ),
        GetPage(
          name: "/home",
          page: () => const HomePage(),
        ),
        GetPage(
          name: "/profile",
          page: () => ProfilePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/bayar",
          page: () => BayarPage(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
