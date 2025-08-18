import 'package:intl/intl.dart';

import '../extensions/string_extension.dart';

class DateUtil {
  static String getCurrentDayOfWeek(String? locale) {
    return DateFormat('EEEE', locale).format(DateTime.now()).capitalize();
  }

  static String getDayOfWeek(DateTime date, String? locale) {
    return DateFormat('EEEE', locale).format(date).capitalize();
  }

  static String getCurrentDay(String? locale) {
    return DateFormat('d MMMM', locale).format(DateTime.now()).toLowerCase();
  }

  static String getDay(DateTime date, String? locale) {
    return DateFormat('d MMMM', locale).format(date).toLowerCase();
  }
}