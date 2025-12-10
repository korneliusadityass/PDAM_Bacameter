import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// Table Rayon
class RayonTable extends Table {
  TextColumn get id => text()();
  TextColumn get nama => text()();
  IntColumn get total => integer()();
  IntColumn get sudahTerbaca => integer()();
  IntColumn get belumTerbaca => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// Table Pelanggan
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
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ========== RAYON OPERATIONS ==========
  // ✅ GUNAKAN RayonTableData, BUKAN Rayon
  Future<List<RayonTableData>> getAllRayons() => select(rayonTable).get();

  Future<RayonTableData?> getRayonById(String id) =>
      (select(rayonTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRayon(RayonTableCompanion rayon) =>
      into(rayonTable).insert(rayon, mode: InsertMode.replace);

  Future<int> updateRayon(RayonTableCompanion rayon) =>
      (update(rayonTable)..where((t) => t.id.equals(rayon.id.value))).write(
        RayonTableCompanion(
          nama: rayon.nama,
          total: rayon.total,
          sudahTerbaca: rayon.sudahTerbaca,
          belumTerbaca: rayon.belumTerbaca,
        ),
      );

  Future<void> insertAllRayons(List<RayonTableCompanion> rayons) async {
    await batch((batch) {
      batch.insertAll(rayonTable, rayons, mode: InsertMode.replace);
    });
  }

  Future<List<RayonTableData>> searchRayons(String query) {
    final searchTerm = '%$query%';
    return (select(
      rayonTable,
    )..where((t) => t.id.like(searchTerm) | t.nama.like(searchTerm))).get();
  }

  // ========== PELANGGAN OPERATIONS ==========
  // ✅ GUNAKAN PelangganTableData, BUKAN Pelanggan
  Future<List<PelangganTableData>> getPelangganByRayon(String rayonId) =>
      (select(pelangganTable)..where((t) => t.rayonId.equals(rayonId))).get();

  Future<PelangganTableData?> getPelangganById(String id) =>
      (select(pelangganTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> updatePembacaanPelanggan({
    required String pelangganId,
    required String standMeter,
    required DateTime tanggalBaca,
  }) => (update(pelangganTable)..where((t) => t.id.equals(pelangganId))).write(
    PelangganTableCompanion(
      sudahDibaca: const Value(true),
      standMeter: Value(standMeter),
      tanggalBaca: Value(tanggalBaca),
      status: const Value('SUDAH'),
    ),
  );

  Future<int> getTotalPelangganByRayon(String rayonId) async {
    final result = await (select(
      pelangganTable,
    )..where((t) => t.rayonId.equals(rayonId))).get();
    return result.length;
  }

  Future<int> getSudahDibacaByRayon(String rayonId) async {
    final result =
        await (select(pelangganTable)..where(
              (t) => t.rayonId.equals(rayonId) & t.sudahDibaca.equals(true),
            ))
            .get();
    return result.length;
  }

  // ========== INITIAL DATA ==========
  Future<void> initializeSampleData() async {
    // Cek apakah data sudah ada
    final existingRayons = await getAllRayons();
    if (existingRayons.isNotEmpty) return;

    // Sample Rayon Data
    final sampleRayons = [
      RayonTableCompanion(
        id: const Value('1021'),
        nama: const Value('BONTOMANAI'),
        total: const Value(6), // Diupdate menjadi 6
        sudahTerbaca: const Value(2), // Diupdate menjadi 2
        belumTerbaca: const Value(4), // Diupdate menjadi 4
      ),
      RayonTableCompanion(
        id: const Value('1022'),
        nama: const Value('BONTOSUNGGU'),
        total: const Value(8), // Diupdate menjadi 8
        sudahTerbaca: const Value(3), // Diupdate menjadi 3
        belumTerbaca: const Value(5), // Diupdate menjadi 5
      ),
      RayonTableCompanion(
        id: const Value('1023'),
        nama: const Value('BONTORAMBA'),
        total: const Value(10), // Diupdate menjadi 10
        sudahTerbaca: const Value(4), // Diupdate menjadi 4
        belumTerbaca: const Value(6), // Diupdate menjadi 6
      ),
    ];

    await insertAllRayons(sampleRayons);

    // Sample Pelanggan Data
    final samplePelanggans = [
      // ========== RAYON 1021 - BONTOMANAI ==========
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P001'),
        rayonId: const Value('1021'),
        nama: const Value('John Doe'),
        alamat: const Value('Jl. Bontomanai No. 1'),
        noMeter: const Value('MTR001'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 15)),
        standMeter: const Value('012345'),
        status: const Value('SUDAH'), // Sudah terupload
      ),
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P002'),
        rayonId: const Value('1021'),
        nama: const Value('Jane Smith'),
        alamat: const Value('Jl. Bontomanai No. 2'),
        noMeter: const Value('MTR002'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 16)),
        standMeter: const Value('023456'),
        status: const Value('SUDAH'), // Sudah terupload
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P003'),
        rayonId: const Value('1021'),
        nama: const Value('Bob Wilson'),
        alamat: const Value('Jl. Bontomanai No. 3'),
        noMeter: const Value('MTR003'),
        // sudahDibaca: default false
        // tanggalBaca: default null
        // standMeter: default null
        // status: default 'BELUM'
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P004'),
        rayonId: const Value('1021'),
        nama: const Value('Alice Brown'),
        alamat: const Value('Jl. Bontomanai No. 4'),
        noMeter: const Value('MTR004'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P005'),
        rayonId: const Value('1021'),
        nama: const Value('Charlie Davis'),
        alamat: const Value('Jl. Bontomanai No. 5'),
        noMeter: const Value('MTR005'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P006'),
        rayonId: const Value('1021'),
        nama: const Value('Diana Evans'),
        alamat: const Value('Jl. Bontomanai No. 6'),
        noMeter: const Value('MTR006'),
      ),

      // ========== RAYON 1022 - BONTOSUNGGU ==========
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P007'),
        rayonId: const Value('1022'),
        nama: const Value('Eva Garcia'),
        alamat: const Value('Jl. Bontosunggu No. 1'),
        noMeter: const Value('MTR007'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 17)),
        standMeter: const Value('034567'),
        status: const Value('SUDAH'),
      ),
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P008'),
        rayonId: const Value('1022'),
        nama: const Value('Frank Harris'),
        alamat: const Value('Jl. Bontosunggu No. 2'),
        noMeter: const Value('MTR008'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 18)),
        standMeter: const Value('045678'),
        status: const Value('SUDAH'),
      ),
      // Sudah terbaca tapi BELUM terupload
      PelangganTableCompanion(
        id: const Value('P009'),
        rayonId: const Value('1022'),
        nama: const Value('Grace Lee'),
        alamat: const Value('Jl. Bontosunggu No. 3'),
        noMeter: const Value('MTR009'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 19)),
        standMeter: const Value('056789'),
        status: const Value('BELUM'), // Belum terupload
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P010'),
        rayonId: const Value('1022'),
        nama: const Value('Henry Martin'),
        alamat: const Value('Jl. Bontosunggu No. 4'),
        noMeter: const Value('MTR010'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P011'),
        rayonId: const Value('1022'),
        nama: const Value('Ivy Nelson'),
        alamat: const Value('Jl. Bontosunggu No. 5'),
        noMeter: const Value('MTR011'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P012'),
        rayonId: const Value('1022'),
        nama: const Value('Jack Owens'),
        alamat: const Value('Jl. Bontosunggu No. 6'),
        noMeter: const Value('MTR012'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P013'),
        rayonId: const Value('1022'),
        nama: const Value('Karen Perez'),
        alamat: const Value('Jl. Bontosunggu No. 7'),
        noMeter: const Value('MTR013'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P014'),
        rayonId: const Value('1022'),
        nama: const Value('Leo Roberts'),
        alamat: const Value('Jl. Bontosunggu No. 8'),
        noMeter: const Value('MTR014'),
      ),

      // ========== RAYON 1023 - BONTORAMBA ==========
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P015'),
        rayonId: const Value('1023'),
        nama: const Value('Mia Scott'),
        alamat: const Value('Jl. Bontoramba No. 1'),
        noMeter: const Value('MTR015'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 20)),
        standMeter: const Value('067890'),
        status: const Value('SUDAH'),
      ),
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P016'),
        rayonId: const Value('1023'),
        nama: const Value('Nathan Taylor'),
        alamat: const Value('Jl. Bontoramba No. 2'),
        noMeter: const Value('MTR016'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 21)),
        standMeter: const Value('078901'),
        status: const Value('SUDAH'),
      ),
      // Sudah terbaca & sudah terupload
      PelangganTableCompanion(
        id: const Value('P017'),
        rayonId: const Value('1023'),
        nama: const Value('Olivia White'),
        alamat: const Value('Jl. Bontoramba No. 3'),
        noMeter: const Value('MTR017'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 22)),
        standMeter: const Value('089012'),
        status: const Value('SUDAH'),
      ),
      // Sudah terbaca tapi BELUM terupload
      PelangganTableCompanion(
        id: const Value('P018'),
        rayonId: const Value('1023'),
        nama: const Value('Paul Young'),
        alamat: const Value('Jl. Bontoramba No. 4'),
        noMeter: const Value('MTR018'),
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime(2024, 1, 23)),
        standMeter: const Value('090123'),
        status: const Value('BELUM'), // Belum terupload
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P019'),
        rayonId: const Value('1023'),
        nama: const Value('Quinn Adams'),
        alamat: const Value('Jl. Bontoramba No. 5'),
        noMeter: const Value('MTR019'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P020'),
        rayonId: const Value('1023'),
        nama: const Value('Rachel Clark'),
        alamat: const Value('Jl. Bontoramba No. 6'),
        noMeter: const Value('MTR020'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P021'),
        rayonId: const Value('1023'),
        nama: const Value('Samuel Walker'),
        alamat: const Value('Jl. Bontoramba No. 7'),
        noMeter: const Value('MTR021'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P022'),
        rayonId: const Value('1023'),
        nama: const Value('Tina Hall'),
        alamat: const Value('Jl. Bontoramba No. 8'),
        noMeter: const Value('MTR022'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P023'),
        rayonId: const Value('1023'),
        nama: const Value('Uma King'),
        alamat: const Value('Jl. Bontoramba No. 9'),
        noMeter: const Value('MTR023'),
      ),
      // Belum terbaca
      PelangganTableCompanion(
        id: const Value('P024'),
        rayonId: const Value('1023'),
        nama: const Value('Victor Lewis'),
        alamat: const Value('Jl. Bontoramba No. 10'),
        noMeter: const Value('MTR024'),
      ),
    ];

    await batch((batch) {
      batch.insertAll(pelangganTable, samplePelanggans);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'baca_meter.db'));
    return NativeDatabase(file);
  });
}
