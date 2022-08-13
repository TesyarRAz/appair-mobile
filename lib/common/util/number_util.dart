import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NumberUtil on int {
  String get rupiahFormat {
    return NumberFormat.currency(
            locale: Get.locale?.languageCode, symbol: "Rp. ", decimalDigits: 0)
        .format(this);
  }

  String get numberFormat {
    return NumberFormat.currency(
            locale: Get.locale?.languageCode, symbol: '', decimalDigits: 0)
        .format(this);
  }
}
