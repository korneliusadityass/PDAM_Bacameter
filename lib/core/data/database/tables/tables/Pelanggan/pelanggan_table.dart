import 'package:drift/drift.dart';
import '../Rayon/rayon_table.dart';

class PelangganTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get idRayon =>
      integer().references(RayonTable, #idRayon)();

  TextColumn get nama => text()();
  TextColumn get alamat => text()();
  TextColumn get noMeter => text()();

  BoolColumn get sudahDibaca =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get tanggalBaca => dateTime().nullable()();

  IntColumn get standMeter => integer().nullable()();

  BoolColumn get statusTerupload =>
      boolean().withDefault(const Constant(false))();
}
