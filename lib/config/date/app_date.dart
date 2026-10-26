import 'package:intl/intl.dart';

class AppDate {
  static String format(DateTime date) {
    return DateFormat.yMMMEd().format(DateTime.now());
  }
}
