import 'dart:convert';

import 'package:appair/repository/auth_repository.dart';
import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/setting_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:appair/service/auth_service.dart';
import 'package:appair/service/info_service.dart';
import 'package:appair/service/setting_service.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:appair/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    var env = await rootBundle.loadStructuredData(
      "environment.json",
      (value) async => await jsonDecode(value),
    );

    initializeDateFormatting();

    // Get.locale = Get.deviceLocale ?? const Locale('id', 'ID');
    
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
  }
}
