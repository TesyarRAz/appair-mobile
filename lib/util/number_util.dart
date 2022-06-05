import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NumberUtil on int {
  String get numberFormat {
    return NumberFormat.currency(locale: Get.locale?.languageCode, symbol: "Rp. ", decimalDigits: 0).format(this);
  }
}