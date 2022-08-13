import 'dart:convert';

import 'package:appair/common/repository/auth_repository.dart';
import 'package:appair/common/repository/info_repository.dart';
import 'package:appair/common/repository/setting_repository.dart';
import 'package:appair/common/repository/transaksi_repository.dart';
import 'package:appair/common/repository/user_repository.dart';
import 'package:appair/common/service/auth_service.dart';
import 'package:appair/common/service/info_service.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:appair/common/service/user_service.dart';
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
    Get.put(env['baseUrl'], tag: 'baseUrl');

    var preferences = Get.put(await SharedPreferences.getInstance());

    // Initialize Repository First
    var transaksiRepository = Get.put(
      TransaksiRepository(
        baseUrl: env['apiUrl'],
      ),
    );

    var infoRepository = Get.put(
      InfoRepository(
        baseUrl: env['apiUrl'],
      ),
    );

    var userRepository = Get.put(
      UserRepository(
        baseUrl: env['apiUrl'],
      ),
    );

    var authRepository = Get.put(
      AuthRepository(
        baseUrl: env['apiUrl'],
      ),
    );

    var settingRepository = Get.put(
      SettingRepository(
        baseUrl: env['apiUrl'],
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
