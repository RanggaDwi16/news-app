import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('d MMM yyyy').format(dateTime);
}

String formatStringDateTime(String dateTime) {
  return DateFormat('d MMM yyyy').format(DateTime.parse(dateTime));
}

String formatNewsPublishedDate(DateTime dateTime) {
  return DateFormat.yMMMd().format(dateTime);
}