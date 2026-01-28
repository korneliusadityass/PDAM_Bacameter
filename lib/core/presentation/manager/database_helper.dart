import 'package:baca_meter/core/data/database/app_database.dart';
import 'package:drift/drift.dart';

class DatabaseHelper {
  final AppDatabase db;

  DatabaseHelper(this.db);

  /// ======================
  /// INIT DUMMY DATA
  /// ======================
  Future<void> initDummyData() async {
    final exist = await db.select(db.rayonTable).get();
    if (exist.isNotEmpty) return;

    await db.transaction(() async {
      await _insertDummyRayon();
      await _insertDummyPelanggan();
    });
  }

  /// ======================
  /// INSERT DUMMY RAYON
  /// ======================
  Future<void> _insertDummyRayon() async {
    final rayons = [
      RayonTableCompanion.insert(
        namaRayon: 'Rayon A',
        totalList: const Value(3),
        totalListTerbaca: const Value(1),
        totalListBelumTerbaca: const Value(2),
      ),
      RayonTableCompanion.insert(
        namaRayon: 'Rayon B',
        totalList:  const Value(2),
        totalListTerbaca:  const Value(0),
        totalListBelumTerbaca:  const Value(2),
      ),
    ];

    await db.batch((batch) {
      batch.insertAll(db.rayonTable, rayons);
    });
  }

  /// ======================
  /// INSERT DUMMY PELANGGAN
  /// ======================
  Future<void> _insertDummyPelanggan() async {
    final pelanggan = [
      // Rayon A
      PelangganTableCompanion.insert(
        idRayon: 1,
        nama: 'Budi Santoso',
        alamat: 'Jl. Merdeka No. 1',
        noMeter: 'MTR001',
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime.now()),
        standMeter: const Value(120),
        statusTerupload: const Value(false),
      ),
      PelangganTableCompanion.insert(
        idRayon: 1,
        nama: 'Siti Aminah',
        alamat: 'Jl. Merdeka No. 2',
        noMeter: 'MTR002',
        sudahDibaca: const Value(false),
        tanggalBaca: const Value(null),
        standMeter: const Value(null),
        statusTerupload: const Value(false),
      ),
      PelangganTableCompanion.insert(
        idRayon: 1,
        nama: 'Andi Wijaya',
        alamat: 'Jl. Merdeka No. 3',
        noMeter: 'MTR003',
        sudahDibaca: const Value(false),
        tanggalBaca: const Value(null),
        standMeter: const Value(null),
        statusTerupload: const Value(false),
      ),

      // Rayon B
      PelangganTableCompanion.insert(
        idRayon: 2,
        nama: 'Dewi Lestari',
        alamat: 'Jl. Sudirman No. 10',
        noMeter: 'MTR004',
        sudahDibaca: const Value(false),
        tanggalBaca: const Value(null),
        standMeter: const Value(null),
        statusTerupload: const Value(false),
      ),
      PelangganTableCompanion.insert(
        idRayon: 2,
        nama: 'Agus Salim',
        alamat: 'Jl. Sudirman No. 11',
        noMeter: 'MTR005',
        sudahDibaca: const Value(false),
        tanggalBaca: const Value(null),
        standMeter: const Value(null),
        statusTerupload: const Value(false),
      ),
    ];

    await db.batch((batch) {
      batch.insertAll(db.pelangganTable, pelanggan);
    });
  }

  // ===== RAYON =====
  Future<List<RayonTableData>> getAllRayons() {
    return db.select(db.rayonTable).get();
  }

  Future<List<RayonTableData>> searchRayons(String keyword) {
    return (db.select(
      db.rayonTable,
    )..where((r) => r.namaRayon.like('%$keyword%'))).get();
  }

  // ===== PELANGGAN =====
  Future<List<PelangganTableData>> getPelangganByRayon(int idRayon) {
    return (db.select(
      db.pelangganTable,
    )..where((p) => p.idRayon.equals(idRayon))).get();
  }

  Future<void> updateStatusBaca({
    required int pelangganId,
    required bool sudahDibaca,
    int? standMeter,
    bool statusTerupload = false,
  }) async {
    await db.transaction(() async {
      // Update pelanggan
      await (db.update(
        db.pelangganTable,
      )..where((p) => p.id.equals(pelangganId))).write(
        PelangganTableCompanion(
          sudahDibaca: Value(sudahDibaca),
          tanggalBaca: Value(sudahDibaca ? DateTime.now() : null),
          standMeter: Value(standMeter),
          statusTerupload: Value(statusTerupload),
        ),
      );

      // Ambil idRayon
      final pelanggan = await (db.select(
        db.pelangganTable,
      )..where((p) => p.id.equals(pelangganId))).getSingle();

      // Hitung ulang total
      final totalTerbaca =
          await (db.select(db.pelangganTable)..where(
                (p) =>
                    p.idRayon.equals(pelanggan.idRayon) &
                    p.sudahDibaca.equals(true),
              ))
              .get();

      final totalBelum =
          await (db.select(db.pelangganTable)..where(
                (p) =>
                    p.idRayon.equals(pelanggan.idRayon) &
                    p.sudahDibaca.equals(false),
              ))
              .get();

      await (db.update(
        db.rayonTable,
      )..where((r) => r.idRayon.equals(pelanggan.idRayon))).write(
        RayonTableCompanion(
          totalListTerbaca: Value(totalTerbaca.length),
          totalListBelumTerbaca: Value(totalBelum.length),
        ),
      );
    });
  }
}
