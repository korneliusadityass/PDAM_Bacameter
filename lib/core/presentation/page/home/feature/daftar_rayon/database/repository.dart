import 'package:drift/drift.dart';
import 'package:baca_meter/core/data/database/database.dart';

class RayonRepository {
  final AppDatabase _database;

  RayonRepository(this._database);

  // ✅ GUNAKAN RayonTableData, BUKAN Rayon
  Future<List<RayonTableData>> getAllRayons() => _database.getAllRayons();
  
  Future<RayonTableData?> getRayonById(String id) => _database.getRayonById(id);
  
  Future<List<RayonTableData>> searchRayons(String query) => 
      _database.searchRayons(query);

  // ✅ GUNAKAN PelangganTableData, BUKAN Pelanggan
  Future<List<PelangganTableData>> getPelangganByRayon(String rayonId) => 
      _database.getPelangganByRayon(rayonId);
  
  Future<int> getTotalPelangganByRayon(String rayonId) => 
      _database.getTotalPelangganByRayon(rayonId);
  
  Future<int> getSudahDibacaByRayon(String rayonId) => 
      _database.getSudahDibacaByRayon(rayonId);

  // Update data
  Future<void> updateRayonStats(String rayonId) async {
    final total = await getTotalPelangganByRayon(rayonId);
    final sudahDibaca = await getSudahDibacaByRayon(rayonId);
    final belumDibaca = total - sudahDibaca;

    // Update rayon table
    final rayon = await getRayonById(rayonId);
    if (rayon != null) {
      await _database.updateRayon(RayonTableCompanion(
        id: Value(rayonId),
        total: Value(total),
        sudahTerbaca: Value(sudahDibaca),
        belumTerbaca: Value(belumDibaca),
      ));
    }
  }

  Future<void> initializeData() => _database.initializeSampleData();
}