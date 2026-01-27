import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class DatabaseHelper {
  final AppDatabase _db;

  DatabaseHelper(this._db);

  // ===== RAYON =====

  Future<List<RayonTableData>> getAllRayons() =>
      _db.getAllRayons();

  Future<RayonTableData?> getRayonById(String id) =>
      _db.getRayonById(id);

  Future<List<RayonTableData>> searchRayons(String query) =>
      _db.searchRayons(query);

  Future<void> updateRayonStats(String rayonId) async {
    final total = await _db.getTotalPelangganByRayon(rayonId);
    final sudah = await _db.getSudahDibacaByRayon(rayonId);

    await _db.updateRayon(
      RayonTableCompanion(
        id: Value(rayonId),
        total: Value(total),
        sudahTerbaca: Value(sudah),
        belumTerbaca: Value(total - sudah),
      ),
    );
  }

  // ===== PELANGGAN =====

  Future<List<PelangganTableData>> getPelangganByRayon(
    String rayonId,
  ) =>
      _db.getPelangganByRayon(rayonId);

  // ===== INIT =====

  Future<void> initializeData() =>
      _db.initializeSampleData();
}
