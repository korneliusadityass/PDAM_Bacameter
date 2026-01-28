import 'dart:io';
import 'package:baca_meter/core/data/database/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/tables/pelanggan_table.dart';
import 'tables/tables/rayon_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [RayonTable, PelangganTable],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'meter.db'));
    return NativeDatabase(file);
  });
}
