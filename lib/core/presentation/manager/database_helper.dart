import 'package:baca_meter/core/data/database/daftar_rayon/app_database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../data/utilities/failure/failure.dart';

class DatabaseHelper {
  final AppDatabase db;

  DatabaseHelper(this.db);

  /// ======================
  /// INIT DUMMY DATA
  /// ======================
  Future<Either<Failure, Unit>> initDummyData() async {
    try {
      final exist = await db.select(db.rayonTable).get();
      if (exist.isNotEmpty) {
        return right(unit);
      }

      await db.transaction(() async {
        await _insertDummyRayon();
        await _insertDummyPelanggan();
      });

      return right(unit);
    } catch (e) {
      return Left(ServerFailure('Gagal inisialisasi data'));
    }
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
        totalList: const Value(2),
        totalListTerbaca: const Value(0),
        totalListBelumTerbaca: const Value(2),
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
        idPelanggan: 1238173123,
        nama: 'Budi Santoso',
        alamat: 'Jl. Merdeka No. 1',
        noMeter: 'MTR001',
        sudahDibaca: const Value(true),
        tanggalBaca: Value(DateTime.now()),
        standMeter: const Value(120),
        statusTerupload: const Value(true),
      ),
      PelangganTableCompanion.insert(
        idRayon: 1,
        nama: 'Siti Aminah',
        idPelanggan: 1238173124,
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
        idPelanggan: 1238173125,
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
        idPelanggan: 1238173001,
        alamat: 'Jl. Sudirman No. 10',
        noMeter: 'MTR004',
        sudahDibaca: const Value(false),
        tanggalBaca: const Value(null),
        standMeter: const Value(null),
        statusTerupload: const Value(false),
      ),
      PelangganTableCompanion.insert(
        idRayon: 2,
        idPelanggan: 1238173002,
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
  Future<Either<Failure, List<RayonTableData>>> getAllRayons() async {
    try {
      final data = await db.select(db.rayonTable).get();
      return right(data);
    } catch (e) {
      return left(ServerFailure('Gagal memuat data rayon'));
    }
  }

  Future<Either<Failure, List<RayonTableData>>> searchRayons(
    String keyword,
  ) async {
    try {
      final result = await (db.select(
        db.rayonTable,
      )..where((r) => r.namaRayon.like('%$keyword%'))).get();

      return right(result);
    } catch (e) {
      return left(ServerFailure('Gagal mencari rayon'));
    }
  }

  // ===== PELANGGAN =====
  Future<Either<Failure, List<PelangganTableData>>> getPelangganByRayon(
    int idRayon,
  ) async {
    try {
      final result = await (db.select(
        db.pelangganTable,
      )..where((p) => p.idRayon.equals(idRayon))).get();

      return right(result);
    } catch (e) {
      return left(ServerFailure('Gagal memuat data pelanggan'));
    }
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

  Future<Either<Failure, List<PelangganTableData>>>
  searchPelangganByLastIdDigit(String lastDigit) async {
    try {
      final query = db.customSelect(
        '''
      SELECT *
      FROM pelanggan_table
      WHERE CAST(id_pelanggan AS TEXT) LIKE ?
      ORDER BY id DESC
      ''',
        variables: [Variable.withString('%$lastDigit')],
        readsFrom: {db.pelangganTable},
      );

      final result = await query
          .map(
            (row) => PelangganTableData(
              id: row.read<int>('id'),
              idRayon: row.read<int>('id_rayon'),
              idPelanggan: row.read<int>('id_pelanggan'),
              nama: row.read<String>('nama'),
              alamat: row.read<String>('alamat'),
              noMeter: row.read<String>('no_meter'),
              sudahDibaca: row.read<bool>('sudah_dibaca'),
              tanggalBaca: row.read<DateTime?>('tanggal_baca'),
              standMeter: row.read<int?>('stand_meter'),
              statusTerupload: row.read<bool>('status_terupload'),
            ),
          )
          .get();

      return right(result);
    } catch (e) {
      return left(ServerFailure('Gagal mencari pelanggan'));
    }
  }

}
