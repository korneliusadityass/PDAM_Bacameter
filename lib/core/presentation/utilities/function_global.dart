import 'package:intl/intl.dart';

class FunctionGlobal {
  String parseStringDate(List<DateTime> datesParam) {
    final DateTime date = datesParam.first;
    final String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }

  static String parseStringDateBackend(List<DateTime> datesParam) {
    final DateTime date = datesParam.first;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }
}