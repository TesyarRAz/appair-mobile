import 'package:appair/binding.dart';
import 'package:appair/screens//bayar/bayar_binding.dart';
import 'package:appair/screens//bayar/bayar_page.dart';
import 'package:appair/screens//home/home_binding.dart';
import 'package:appair/screens//home/home_page.dart';
import 'package:appair/screens//login/login_binding.dart';
import 'package:appair/screens//login/login_page.dart';
import 'package:appair/screens//profile/profile_binding.dart';
import 'package:appair/screens//profile/profile_page.dart';
import 'package:appair/screens//splash/splash_binding.dart';
import 'package:appair/screens//splash/splash_page.dart';
import 'package:appair/screens/setting/change_password_binding.dart';
import 'package:appair/screens/setting/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBinding().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.onlyBuilder,
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
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: "/home",
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/profile",
          page: () => ProfilePage(),
          transition: Transition.rightToLeft,
          binding: ProfileBinding(),
        ),
        GetPage(
          name: "/bayar",
          page: () => const BayarPage(),
          transition: Transition.rightToLeft,
          binding: BayarBinding(),
        ),
        GetPage(
          name: "/change-password",
          page: () => ChangePasswordPage(),
          transition: Transition.rightToLeft,
          binding: ChangePasswordBinding(),
        ),
      ],
    );
  }
}
