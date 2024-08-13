import 'package:intl/intl.dart';

String formatDateByDMMMYYYY(DateTime dateTime) {
  return DateFormat('d MMM, yyyy').format(dateTime);
}
