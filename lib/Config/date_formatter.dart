import 'package:intl/intl.dart';

String dateFormatter(String date) {
  String formattedDate = '';

  try {
    Intl.defaultLocale = 'en';
    var dateFormat = DateFormat("E, MMM d");
    var utcDate = dateFormat.format(DateTime.parse(date));
    var localDate = dateFormat.parse(utcDate, false).toString();
    formattedDate = dateFormat.format(DateTime.parse(localDate));
  } catch (e) {}

  return formattedDate;
}
