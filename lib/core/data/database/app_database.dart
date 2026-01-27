import 'package:drift/drift.dart';

import '../../presentation/manager/database_connection.dart';

part 'database.g.dart';

class RayonTable extends Table {
  TextColumn get id => text()();
  TextColumn get nama => text()();
  IntColumn get total => integer()();
  IntColumn get sudahTerbaca => integer()();
  IntColumn get belumTerbaca => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class PelangganTable extends Table {
  TextColumn get id => text()();
  TextColumn get rayonId => text().references(RayonTable, #id)();
  TextColumn get nama => text()();
  TextColumn get alamat => text()();
  TextColumn get noMeter => text()();
  BoolColumn get sudahDibaca => boolean().withDefault(const Constant(false))();
  DateTimeColumn get tanggalBaca => dateTime().nullable()();
  TextColumn get standMeter => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('BELUM'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [RayonTable, PelangganTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // ===== RAYON =====

  Future<List<RayonTableData>> getAllRayons() => select(rayonTable).get();

  Future<RayonTableData?> getRayonById(String id) =>
      (select(rayonTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<RayonTableData>> searchRayons(String query) =>
      (select(rayonTable)..where((t) => t.nama.like('%$query%'))).get();

  Future<void> updateRayon(RayonTableCompanion data) => (update(
    rayonTable,
  )..where((t) => t.id.equals(data.id.value))).write(data);

  // ===== PELANGGAN =====

  Future<List<PelangganTableData>> getPelangganByRayon(String rayonId) =>
      (select(pelangganTable)..where((t) => t.rayonId.equals(rayonId))).get();

  Future<int> getTotalPelangganByRayon(String rayonId) async {
    final q = selectOnly(pelangganTable)
      ..addColumns([pelangganTable.id.count()])
      ..where(pelangganTable.rayonId.equals(rayonId));

    return (await q.getSingle()).read(pelangganTable.id.count()) ?? 0;
  }

  Future<int> getSudahDibacaByRayon(String rayonId) async {
    final q = selectOnly(pelangganTable)
      ..addColumns([pelangganTable.id.count()])
      ..where(
        pelangganTable.rayonId.equals(rayonId) &
            pelangganTable.sudahDibaca.equals(true),
      );

    return (await q.getSingle()).read(pelangganTable.id.count()) ?? 0;
  }

  // ===== INIT =====

  Future<void> initializeSampleData() async {
    // isi sesuai kebutuhan
  }
}
