import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toReadable() {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }

  String toTimeOnly() {
    return DateFormat('hh:mm a').format(this);
  }

  String toDateOnly() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
