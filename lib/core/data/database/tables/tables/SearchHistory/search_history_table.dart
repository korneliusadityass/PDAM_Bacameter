import 'package:drift/drift.dart';

import '../Pelanggan/pelanggan_table.dart';

class SearchHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get pelangganId =>
      integer().references(PelangganTable, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
