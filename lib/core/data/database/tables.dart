import 'package:drift/drift.dart';

class MeterReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerId => text()();
  TextColumn get customerName => text()();
  TextColumn get address => text()();
  RealColumn get meterValue => real()();
  DateTimeColumn get readingDate => dateTime()();
  TextColumn get imageUrl => text().nullable()(); // simpan nama file saja
}