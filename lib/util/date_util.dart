import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension StringUtil on String {
  DateTime toDateTime([String fromFormat = 'yyyy-MM-dd']) {
    return DateFormat(fromFormat).parse(this);
  }
}

extension DateUtil on DateTime {
  String toDateFormat([String toFormat = 'dd-MM-yyyy']) {
    return DateFormat(toFormat, Get.locale?.toString()).format(this);
  }
}