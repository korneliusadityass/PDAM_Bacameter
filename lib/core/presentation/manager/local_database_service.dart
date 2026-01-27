import '../../data/database/app_database.dart';
import 'database_helper.dart';

class LocalDatabaseService {
  final DatabaseHelper _helper;

  LocalDatabaseService(this._helper);

  // ===== INIT =====
  Future<void> initialize() =>
      _helper.initializeData();

  // ===== RAYON =====
  Future<List<RayonTableData>> getRayons() =>
      _helper.getAllRayons();

  Future<List<RayonTableData>> searchRayons(String query) =>
      _helper.searchRayons(query);

  Future<void> updateRayonStats(String rayonId) =>
      _helper.updateRayonStats(rayonId);

  // ===== PELANGGAN =====
  Future<List<PelangganTableData>> getPelangganByRayon(
    String rayonId,
  ) =>
      _helper.getPelangganByRayon(rayonId);
}
