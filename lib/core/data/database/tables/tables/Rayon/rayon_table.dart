import 'package:drift/drift.dart';

class RayonTable extends Table {
  IntColumn get idRayon => integer().autoIncrement()();
  TextColumn get namaRayon => text()();

  IntColumn get totalList =>
      integer().withDefault(const Constant(0))();

  IntColumn get totalListTerbaca =>
      integer().withDefault(const Constant(0))();

  IntColumn get totalListBelumTerbaca =>
      integer().withDefault(const Constant(0))();
}
