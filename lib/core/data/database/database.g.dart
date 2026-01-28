// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'database.dart';
// // part of 'app_database.dart';

// class $RayonTableTable extends RayonTable
//     with TableInfo<$RayonTableTable, RayonTableData> {
//   @override
//   final GeneratedDatabase attachedDatabase;
//   final String? _alias;
//   $RayonTableTable(this.attachedDatabase, [this._alias]);
//   static const VerificationMeta _idMeta = const VerificationMeta('id');
//   @override
//   late final GeneratedColumn<String> id = GeneratedColumn<String>(
//     'id',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _namaMeta = const VerificationMeta('nama');
//   @override
//   late final GeneratedColumn<String> nama = GeneratedColumn<String>(
//     'nama',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _totalMeta = const VerificationMeta('total');
//   @override
//   late final GeneratedColumn<int> total = GeneratedColumn<int>(
//     'total',
//     aliasedName,
//     false,
//     type: DriftSqlType.int,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _sudahTerbacaMeta = const VerificationMeta(
//     'sudahTerbaca',
//   );
//   @override
//   late final GeneratedColumn<int> sudahTerbaca = GeneratedColumn<int>(
//     'sudah_terbaca',
//     aliasedName,
//     false,
//     type: DriftSqlType.int,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _belumTerbacaMeta = const VerificationMeta(
//     'belumTerbaca',
//   );
//   @override
//   late final GeneratedColumn<int> belumTerbaca = GeneratedColumn<int>(
//     'belum_terbaca',
//     aliasedName,
//     false,
//     type: DriftSqlType.int,
//     requiredDuringInsert: true,
//   );
//   @override
//   List<GeneratedColumn> get $columns => [
//     id,
//     nama,
//     total,
//     sudahTerbaca,
//     belumTerbaca,
//   ];
//   @override
//   String get aliasedName => _alias ?? actualTableName;
//   @override
//   String get actualTableName => $name;
//   static const String $name = 'rayon_table';
//   @override
//   VerificationContext validateIntegrity(
//     Insertable<RayonTableData> instance, {
//     bool isInserting = false,
//   }) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('id')) {
//       context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
//     } else if (isInserting) {
//       context.missing(_idMeta);
//     }
//     if (data.containsKey('nama')) {
//       context.handle(
//         _namaMeta,
//         nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_namaMeta);
//     }
//     if (data.containsKey('total')) {
//       context.handle(
//         _totalMeta,
//         total.isAcceptableOrUnknown(data['total']!, _totalMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_totalMeta);
//     }
//     if (data.containsKey('sudah_terbaca')) {
//       context.handle(
//         _sudahTerbacaMeta,
//         sudahTerbaca.isAcceptableOrUnknown(
//           data['sudah_terbaca']!,
//           _sudahTerbacaMeta,
//         ),
//       );
//     } else if (isInserting) {
//       context.missing(_sudahTerbacaMeta);
//     }
//     if (data.containsKey('belum_terbaca')) {
//       context.handle(
//         _belumTerbacaMeta,
//         belumTerbaca.isAcceptableOrUnknown(
//           data['belum_terbaca']!,
//           _belumTerbacaMeta,
//         ),
//       );
//     } else if (isInserting) {
//       context.missing(_belumTerbacaMeta);
//     }
//     return context;
//   }

//   @override
//   Set<GeneratedColumn> get $primaryKey => {id};
//   @override
//   RayonTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
//     return RayonTableData(
//       id: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}id'],
//       )!,
//       nama: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}nama'],
//       )!,
//       total: attachedDatabase.typeMapping.read(
//         DriftSqlType.int,
//         data['${effectivePrefix}total'],
//       )!,
//       sudahTerbaca: attachedDatabase.typeMapping.read(
//         DriftSqlType.int,
//         data['${effectivePrefix}sudah_terbaca'],
//       )!,
//       belumTerbaca: attachedDatabase.typeMapping.read(
//         DriftSqlType.int,
//         data['${effectivePrefix}belum_terbaca'],
//       )!,
//     );
//   }

//   @override
//   $RayonTableTable createAlias(String alias) {
//     return $RayonTableTable(attachedDatabase, alias);
//   }
// }

// class RayonTableData extends DataClass implements Insertable<RayonTableData> {
//   final String id;
//   final String nama;
//   final int total;
//   final int sudahTerbaca;
//   final int belumTerbaca;
//   const RayonTableData({
//     required this.id,
//     required this.nama,
//     required this.total,
//     required this.sudahTerbaca,
//     required this.belumTerbaca,
//   });
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['id'] = Variable<String>(id);
//     map['nama'] = Variable<String>(nama);
//     map['total'] = Variable<int>(total);
//     map['sudah_terbaca'] = Variable<int>(sudahTerbaca);
//     map['belum_terbaca'] = Variable<int>(belumTerbaca);
//     return map;
//   }

//   RayonTableCompanion toCompanion(bool nullToAbsent) {
//     return RayonTableCompanion(
//       id: Value(id),
//       nama: Value(nama),
//       total: Value(total),
//       sudahTerbaca: Value(sudahTerbaca),
//       belumTerbaca: Value(belumTerbaca),
//     );
//   }

//   factory RayonTableData.fromJson(
//     Map<String, dynamic> json, {
//     ValueSerializer? serializer,
//   }) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return RayonTableData(
//       id: serializer.fromJson<String>(json['id']),
//       nama: serializer.fromJson<String>(json['nama']),
//       total: serializer.fromJson<int>(json['total']),
//       sudahTerbaca: serializer.fromJson<int>(json['sudahTerbaca']),
//       belumTerbaca: serializer.fromJson<int>(json['belumTerbaca']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'id': serializer.toJson<String>(id),
//       'nama': serializer.toJson<String>(nama),
//       'total': serializer.toJson<int>(total),
//       'sudahTerbaca': serializer.toJson<int>(sudahTerbaca),
//       'belumTerbaca': serializer.toJson<int>(belumTerbaca),
//     };
//   }

//   RayonTableData copyWith({
//     String? id,
//     String? nama,
//     int? total,
//     int? sudahTerbaca,
//     int? belumTerbaca,
//   }) => RayonTableData(
//     id: id ?? this.id,
//     nama: nama ?? this.nama,
//     total: total ?? this.total,
//     sudahTerbaca: sudahTerbaca ?? this.sudahTerbaca,
//     belumTerbaca: belumTerbaca ?? this.belumTerbaca,
//   );
//   RayonTableData copyWithCompanion(RayonTableCompanion data) {
//     return RayonTableData(
//       id: data.id.present ? data.id.value : this.id,
//       nama: data.nama.present ? data.nama.value : this.nama,
//       total: data.total.present ? data.total.value : this.total,
//       sudahTerbaca: data.sudahTerbaca.present
//           ? data.sudahTerbaca.value
//           : this.sudahTerbaca,
//       belumTerbaca: data.belumTerbaca.present
//           ? data.belumTerbaca.value
//           : this.belumTerbaca,
//     );
//   }

//   @override
//   String toString() {
//     return (StringBuffer('RayonTableData(')
//           ..write('id: $id, ')
//           ..write('nama: $nama, ')
//           ..write('total: $total, ')
//           ..write('sudahTerbaca: $sudahTerbaca, ')
//           ..write('belumTerbaca: $belumTerbaca')
//           ..write(')'))
//         .toString();
//   }

//   @override
//   int get hashCode => Object.hash(id, nama, total, sudahTerbaca, belumTerbaca);
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is RayonTableData &&
//           other.id == this.id &&
//           other.nama == this.nama &&
//           other.total == this.total &&
//           other.sudahTerbaca == this.sudahTerbaca &&
//           other.belumTerbaca == this.belumTerbaca);
// }

// class RayonTableCompanion extends UpdateCompanion<RayonTableData> {
//   final Value<String> id;
//   final Value<String> nama;
//   final Value<int> total;
//   final Value<int> sudahTerbaca;
//   final Value<int> belumTerbaca;
//   final Value<int> rowid;
//   const RayonTableCompanion({
//     this.id = const Value.absent(),
//     this.nama = const Value.absent(),
//     this.total = const Value.absent(),
//     this.sudahTerbaca = const Value.absent(),
//     this.belumTerbaca = const Value.absent(),
//     this.rowid = const Value.absent(),
//   });
//   RayonTableCompanion.insert({
//     required String id,
//     required String nama,
//     required int total,
//     required int sudahTerbaca,
//     required int belumTerbaca,
//     this.rowid = const Value.absent(),
//   }) : id = Value(id),
//        nama = Value(nama),
//        total = Value(total),
//        sudahTerbaca = Value(sudahTerbaca),
//        belumTerbaca = Value(belumTerbaca);
//   static Insertable<RayonTableData> custom({
//     Expression<String>? id,
//     Expression<String>? nama,
//     Expression<int>? total,
//     Expression<int>? sudahTerbaca,
//     Expression<int>? belumTerbaca,
//     Expression<int>? rowid,
//   }) {
//     return RawValuesInsertable({
//       if (id != null) 'id': id,
//       if (nama != null) 'nama': nama,
//       if (total != null) 'total': total,
//       if (sudahTerbaca != null) 'sudah_terbaca': sudahTerbaca,
//       if (belumTerbaca != null) 'belum_terbaca': belumTerbaca,
//       if (rowid != null) 'rowid': rowid,
//     });
//   }

//   RayonTableCompanion copyWith({
//     Value<String>? id,
//     Value<String>? nama,
//     Value<int>? total,
//     Value<int>? sudahTerbaca,
//     Value<int>? belumTerbaca,
//     Value<int>? rowid,
//   }) {
//     return RayonTableCompanion(
//       id: id ?? this.id,
//       nama: nama ?? this.nama,
//       total: total ?? this.total,
//       sudahTerbaca: sudahTerbaca ?? this.sudahTerbaca,
//       belumTerbaca: belumTerbaca ?? this.belumTerbaca,
//       rowid: rowid ?? this.rowid,
//     );
//   }

//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (id.present) {
//       map['id'] = Variable<String>(id.value);
//     }
//     if (nama.present) {
//       map['nama'] = Variable<String>(nama.value);
//     }
//     if (total.present) {
//       map['total'] = Variable<int>(total.value);
//     }
//     if (sudahTerbaca.present) {
//       map['sudah_terbaca'] = Variable<int>(sudahTerbaca.value);
//     }
//     if (belumTerbaca.present) {
//       map['belum_terbaca'] = Variable<int>(belumTerbaca.value);
//     }
//     if (rowid.present) {
//       map['rowid'] = Variable<int>(rowid.value);
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return (StringBuffer('RayonTableCompanion(')
//           ..write('id: $id, ')
//           ..write('nama: $nama, ')
//           ..write('total: $total, ')
//           ..write('sudahTerbaca: $sudahTerbaca, ')
//           ..write('belumTerbaca: $belumTerbaca, ')
//           ..write('rowid: $rowid')
//           ..write(')'))
//         .toString();
//   }
// }

// class $PelangganTableTable extends PelangganTable
//     with TableInfo<$PelangganTableTable, PelangganTableData> {
//   @override
//   final GeneratedDatabase attachedDatabase;
//   final String? _alias;
//   $PelangganTableTable(this.attachedDatabase, [this._alias]);
//   static const VerificationMeta _idMeta = const VerificationMeta('id');
//   @override
//   late final GeneratedColumn<String> id = GeneratedColumn<String>(
//     'id',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _rayonIdMeta = const VerificationMeta(
//     'rayonId',
//   );
//   @override
//   late final GeneratedColumn<String> rayonId = GeneratedColumn<String>(
//     'rayon_id',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//     defaultConstraints: GeneratedColumn.constraintIsAlways(
//       'REFERENCES rayon_table (id)',
//     ),
//   );
//   static const VerificationMeta _namaMeta = const VerificationMeta('nama');
//   @override
//   late final GeneratedColumn<String> nama = GeneratedColumn<String>(
//     'nama',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _alamatMeta = const VerificationMeta('alamat');
//   @override
//   late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
//     'alamat',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _noMeterMeta = const VerificationMeta(
//     'noMeter',
//   );
//   @override
//   late final GeneratedColumn<String> noMeter = GeneratedColumn<String>(
//     'no_meter',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: true,
//   );
//   static const VerificationMeta _sudahDibacaMeta = const VerificationMeta(
//     'sudahDibaca',
//   );
//   @override
//   late final GeneratedColumn<bool> sudahDibaca = GeneratedColumn<bool>(
//     'sudah_dibaca',
//     aliasedName,
//     false,
//     type: DriftSqlType.bool,
//     requiredDuringInsert: false,
//     defaultConstraints: GeneratedColumn.constraintIsAlways(
//       'CHECK ("sudah_dibaca" IN (0, 1))',
//     ),
//     defaultValue: const Constant(false),
//   );
//   static const VerificationMeta _tanggalBacaMeta = const VerificationMeta(
//     'tanggalBaca',
//   );
//   @override
//   late final GeneratedColumn<DateTime> tanggalBaca = GeneratedColumn<DateTime>(
//     'tanggal_baca',
//     aliasedName,
//     true,
//     type: DriftSqlType.dateTime,
//     requiredDuringInsert: false,
//   );
//   static const VerificationMeta _standMeterMeta = const VerificationMeta(
//     'standMeter',
//   );
//   @override
//   late final GeneratedColumn<String> standMeter = GeneratedColumn<String>(
//     'stand_meter',
//     aliasedName,
//     true,
//     type: DriftSqlType.string,
//     requiredDuringInsert: false,
//   );
//   static const VerificationMeta _statusMeta = const VerificationMeta('status');
//   @override
//   late final GeneratedColumn<String> status = GeneratedColumn<String>(
//     'status',
//     aliasedName,
//     false,
//     type: DriftSqlType.string,
//     requiredDuringInsert: false,
//     defaultValue: const Constant('BELUM'),
//   );
//   @override
//   List<GeneratedColumn> get $columns => [
//     id,
//     rayonId,
//     nama,
//     alamat,
//     noMeter,
//     sudahDibaca,
//     tanggalBaca,
//     standMeter,
//     status,
//   ];
//   @override
//   String get aliasedName => _alias ?? actualTableName;
//   @override
//   String get actualTableName => $name;
//   static const String $name = 'pelanggan_table';
//   @override
//   VerificationContext validateIntegrity(
//     Insertable<PelangganTableData> instance, {
//     bool isInserting = false,
//   }) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('id')) {
//       context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
//     } else if (isInserting) {
//       context.missing(_idMeta);
//     }
//     if (data.containsKey('rayon_id')) {
//       context.handle(
//         _rayonIdMeta,
//         rayonId.isAcceptableOrUnknown(data['rayon_id']!, _rayonIdMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_rayonIdMeta);
//     }
//     if (data.containsKey('nama')) {
//       context.handle(
//         _namaMeta,
//         nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_namaMeta);
//     }
//     if (data.containsKey('alamat')) {
//       context.handle(
//         _alamatMeta,
//         alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_alamatMeta);
//     }
//     if (data.containsKey('no_meter')) {
//       context.handle(
//         _noMeterMeta,
//         noMeter.isAcceptableOrUnknown(data['no_meter']!, _noMeterMeta),
//       );
//     } else if (isInserting) {
//       context.missing(_noMeterMeta);
//     }
//     if (data.containsKey('sudah_dibaca')) {
//       context.handle(
//         _sudahDibacaMeta,
//         sudahDibaca.isAcceptableOrUnknown(
//           data['sudah_dibaca']!,
//           _sudahDibacaMeta,
//         ),
//       );
//     }
//     if (data.containsKey('tanggal_baca')) {
//       context.handle(
//         _tanggalBacaMeta,
//         tanggalBaca.isAcceptableOrUnknown(
//           data['tanggal_baca']!,
//           _tanggalBacaMeta,
//         ),
//       );
//     }
//     if (data.containsKey('stand_meter')) {
//       context.handle(
//         _standMeterMeta,
//         standMeter.isAcceptableOrUnknown(data['stand_meter']!, _standMeterMeta),
//       );
//     }
//     if (data.containsKey('status')) {
//       context.handle(
//         _statusMeta,
//         status.isAcceptableOrUnknown(data['status']!, _statusMeta),
//       );
//     }
//     return context;
//   }

//   @override
//   Set<GeneratedColumn> get $primaryKey => {id};
//   @override
//   PelangganTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
//     return PelangganTableData(
//       id: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}id'],
//       )!,
//       rayonId: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}rayon_id'],
//       )!,
//       nama: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}nama'],
//       )!,
//       alamat: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}alamat'],
//       )!,
//       noMeter: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}no_meter'],
//       )!,
//       sudahDibaca: attachedDatabase.typeMapping.read(
//         DriftSqlType.bool,
//         data['${effectivePrefix}sudah_dibaca'],
//       )!,
//       tanggalBaca: attachedDatabase.typeMapping.read(
//         DriftSqlType.dateTime,
//         data['${effectivePrefix}tanggal_baca'],
//       ),
//       standMeter: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}stand_meter'],
//       ),
//       status: attachedDatabase.typeMapping.read(
//         DriftSqlType.string,
//         data['${effectivePrefix}status'],
//       )!,
//     );
//   }

//   @override
//   $PelangganTableTable createAlias(String alias) {
//     return $PelangganTableTable(attachedDatabase, alias);
//   }
// }

// class PelangganTableData extends DataClass
//     implements Insertable<PelangganTableData> {
//   final String id;
//   final String rayonId;
//   final String nama;
//   final String alamat;
//   final String noMeter;
//   final bool sudahDibaca;
//   final DateTime? tanggalBaca;
//   final String? standMeter;
//   final String status;
//   const PelangganTableData({
//     required this.id,
//     required this.rayonId,
//     required this.nama,
//     required this.alamat,
//     required this.noMeter,
//     required this.sudahDibaca,
//     this.tanggalBaca,
//     this.standMeter,
//     required this.status,
//   });
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['id'] = Variable<String>(id);
//     map['rayon_id'] = Variable<String>(rayonId);
//     map['nama'] = Variable<String>(nama);
//     map['alamat'] = Variable<String>(alamat);
//     map['no_meter'] = Variable<String>(noMeter);
//     map['sudah_dibaca'] = Variable<bool>(sudahDibaca);
//     if (!nullToAbsent || tanggalBaca != null) {
//       map['tanggal_baca'] = Variable<DateTime>(tanggalBaca);
//     }
//     if (!nullToAbsent || standMeter != null) {
//       map['stand_meter'] = Variable<String>(standMeter);
//     }
//     map['status'] = Variable<String>(status);
//     return map;
//   }

//   PelangganTableCompanion toCompanion(bool nullToAbsent) {
//     return PelangganTableCompanion(
//       id: Value(id),
//       rayonId: Value(rayonId),
//       nama: Value(nama),
//       alamat: Value(alamat),
//       noMeter: Value(noMeter),
//       sudahDibaca: Value(sudahDibaca),
//       tanggalBaca: tanggalBaca == null && nullToAbsent
//           ? const Value.absent()
//           : Value(tanggalBaca),
//       standMeter: standMeter == null && nullToAbsent
//           ? const Value.absent()
//           : Value(standMeter),
//       status: Value(status),
//     );
//   }

//   factory PelangganTableData.fromJson(
//     Map<String, dynamic> json, {
//     ValueSerializer? serializer,
//   }) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return PelangganTableData(
//       id: serializer.fromJson<String>(json['id']),
//       rayonId: serializer.fromJson<String>(json['rayonId']),
//       nama: serializer.fromJson<String>(json['nama']),
//       alamat: serializer.fromJson<String>(json['alamat']),
//       noMeter: serializer.fromJson<String>(json['noMeter']),
//       sudahDibaca: serializer.fromJson<bool>(json['sudahDibaca']),
//       tanggalBaca: serializer.fromJson<DateTime?>(json['tanggalBaca']),
//       standMeter: serializer.fromJson<String?>(json['standMeter']),
//       status: serializer.fromJson<String>(json['status']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'id': serializer.toJson<String>(id),
//       'rayonId': serializer.toJson<String>(rayonId),
//       'nama': serializer.toJson<String>(nama),
//       'alamat': serializer.toJson<String>(alamat),
//       'noMeter': serializer.toJson<String>(noMeter),
//       'sudahDibaca': serializer.toJson<bool>(sudahDibaca),
//       'tanggalBaca': serializer.toJson<DateTime?>(tanggalBaca),
//       'standMeter': serializer.toJson<String?>(standMeter),
//       'status': serializer.toJson<String>(status),
//     };
//   }

//   PelangganTableData copyWith({
//     String? id,
//     String? rayonId,
//     String? nama,
//     String? alamat,
//     String? noMeter,
//     bool? sudahDibaca,
//     Value<DateTime?> tanggalBaca = const Value.absent(),
//     Value<String?> standMeter = const Value.absent(),
//     String? status,
//   }) => PelangganTableData(
//     id: id ?? this.id,
//     rayonId: rayonId ?? this.rayonId,
//     nama: nama ?? this.nama,
//     alamat: alamat ?? this.alamat,
//     noMeter: noMeter ?? this.noMeter,
//     sudahDibaca: sudahDibaca ?? this.sudahDibaca,
//     tanggalBaca: tanggalBaca.present ? tanggalBaca.value : this.tanggalBaca,
//     standMeter: standMeter.present ? standMeter.value : this.standMeter,
//     status: status ?? this.status,
//   );
//   PelangganTableData copyWithCompanion(PelangganTableCompanion data) {
//     return PelangganTableData(
//       id: data.id.present ? data.id.value : this.id,
//       rayonId: data.rayonId.present ? data.rayonId.value : this.rayonId,
//       nama: data.nama.present ? data.nama.value : this.nama,
//       alamat: data.alamat.present ? data.alamat.value : this.alamat,
//       noMeter: data.noMeter.present ? data.noMeter.value : this.noMeter,
//       sudahDibaca: data.sudahDibaca.present
//           ? data.sudahDibaca.value
//           : this.sudahDibaca,
//       tanggalBaca: data.tanggalBaca.present
//           ? data.tanggalBaca.value
//           : this.tanggalBaca,
//       standMeter: data.standMeter.present
//           ? data.standMeter.value
//           : this.standMeter,
//       status: data.status.present ? data.status.value : this.status,
//     );
//   }

//   @override
//   String toString() {
//     return (StringBuffer('PelangganTableData(')
//           ..write('id: $id, ')
//           ..write('rayonId: $rayonId, ')
//           ..write('nama: $nama, ')
//           ..write('alamat: $alamat, ')
//           ..write('noMeter: $noMeter, ')
//           ..write('sudahDibaca: $sudahDibaca, ')
//           ..write('tanggalBaca: $tanggalBaca, ')
//           ..write('standMeter: $standMeter, ')
//           ..write('status: $status')
//           ..write(')'))
//         .toString();
//   }

//   @override
//   int get hashCode => Object.hash(
//     id,
//     rayonId,
//     nama,
//     alamat,
//     noMeter,
//     sudahDibaca,
//     tanggalBaca,
//     standMeter,
//     status,
//   );
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is PelangganTableData &&
//           other.id == this.id &&
//           other.rayonId == this.rayonId &&
//           other.nama == this.nama &&
//           other.alamat == this.alamat &&
//           other.noMeter == this.noMeter &&
//           other.sudahDibaca == this.sudahDibaca &&
//           other.tanggalBaca == this.tanggalBaca &&
//           other.standMeter == this.standMeter &&
//           other.status == this.status);
// }

// class PelangganTableCompanion extends UpdateCompanion<PelangganTableData> {
//   final Value<String> id;
//   final Value<String> rayonId;
//   final Value<String> nama;
//   final Value<String> alamat;
//   final Value<String> noMeter;
//   final Value<bool> sudahDibaca;
//   final Value<DateTime?> tanggalBaca;
//   final Value<String?> standMeter;
//   final Value<String> status;
//   final Value<int> rowid;
//   const PelangganTableCompanion({
//     this.id = const Value.absent(),
//     this.rayonId = const Value.absent(),
//     this.nama = const Value.absent(),
//     this.alamat = const Value.absent(),
//     this.noMeter = const Value.absent(),
//     this.sudahDibaca = const Value.absent(),
//     this.tanggalBaca = const Value.absent(),
//     this.standMeter = const Value.absent(),
//     this.status = const Value.absent(),
//     this.rowid = const Value.absent(),
//   });
//   PelangganTableCompanion.insert({
//     required String id,
//     required String rayonId,
//     required String nama,
//     required String alamat,
//     required String noMeter,
//     this.sudahDibaca = const Value.absent(),
//     this.tanggalBaca = const Value.absent(),
//     this.standMeter = const Value.absent(),
//     this.status = const Value.absent(),
//     this.rowid = const Value.absent(),
//   }) : id = Value(id),
//        rayonId = Value(rayonId),
//        nama = Value(nama),
//        alamat = Value(alamat),
//        noMeter = Value(noMeter);
//   static Insertable<PelangganTableData> custom({
//     Expression<String>? id,
//     Expression<String>? rayonId,
//     Expression<String>? nama,
//     Expression<String>? alamat,
//     Expression<String>? noMeter,
//     Expression<bool>? sudahDibaca,
//     Expression<DateTime>? tanggalBaca,
//     Expression<String>? standMeter,
//     Expression<String>? status,
//     Expression<int>? rowid,
//   }) {
//     return RawValuesInsertable({
//       if (id != null) 'id': id,
//       if (rayonId != null) 'rayon_id': rayonId,
//       if (nama != null) 'nama': nama,
//       if (alamat != null) 'alamat': alamat,
//       if (noMeter != null) 'no_meter': noMeter,
//       if (sudahDibaca != null) 'sudah_dibaca': sudahDibaca,
//       if (tanggalBaca != null) 'tanggal_baca': tanggalBaca,
//       if (standMeter != null) 'stand_meter': standMeter,
//       if (status != null) 'status': status,
//       if (rowid != null) 'rowid': rowid,
//     });
//   }

//   PelangganTableCompanion copyWith({
//     Value<String>? id,
//     Value<String>? rayonId,
//     Value<String>? nama,
//     Value<String>? alamat,
//     Value<String>? noMeter,
//     Value<bool>? sudahDibaca,
//     Value<DateTime?>? tanggalBaca,
//     Value<String?>? standMeter,
//     Value<String>? status,
//     Value<int>? rowid,
//   }) {
//     return PelangganTableCompanion(
//       id: id ?? this.id,
//       rayonId: rayonId ?? this.rayonId,
//       nama: nama ?? this.nama,
//       alamat: alamat ?? this.alamat,
//       noMeter: noMeter ?? this.noMeter,
//       sudahDibaca: sudahDibaca ?? this.sudahDibaca,
//       tanggalBaca: tanggalBaca ?? this.tanggalBaca,
//       standMeter: standMeter ?? this.standMeter,
//       status: status ?? this.status,
//       rowid: rowid ?? this.rowid,
//     );
//   }

//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (id.present) {
//       map['id'] = Variable<String>(id.value);
//     }
//     if (rayonId.present) {
//       map['rayon_id'] = Variable<String>(rayonId.value);
//     }
//     if (nama.present) {
//       map['nama'] = Variable<String>(nama.value);
//     }
//     if (alamat.present) {
//       map['alamat'] = Variable<String>(alamat.value);
//     }
//     if (noMeter.present) {
//       map['no_meter'] = Variable<String>(noMeter.value);
//     }
//     if (sudahDibaca.present) {
//       map['sudah_dibaca'] = Variable<bool>(sudahDibaca.value);
//     }
//     if (tanggalBaca.present) {
//       map['tanggal_baca'] = Variable<DateTime>(tanggalBaca.value);
//     }
//     if (standMeter.present) {
//       map['stand_meter'] = Variable<String>(standMeter.value);
//     }
//     if (status.present) {
//       map['status'] = Variable<String>(status.value);
//     }
//     if (rowid.present) {
//       map['rowid'] = Variable<int>(rowid.value);
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return (StringBuffer('PelangganTableCompanion(')
//           ..write('id: $id, ')
//           ..write('rayonId: $rayonId, ')
//           ..write('nama: $nama, ')
//           ..write('alamat: $alamat, ')
//           ..write('noMeter: $noMeter, ')
//           ..write('sudahDibaca: $sudahDibaca, ')
//           ..write('tanggalBaca: $tanggalBaca, ')
//           ..write('standMeter: $standMeter, ')
//           ..write('status: $status, ')
//           ..write('rowid: $rowid')
//           ..write(')'))
//         .toString();
//   }
// }

// abstract class _$AppDatabase extends GeneratedDatabase {
//   _$AppDatabase(QueryExecutor e) : super(e);
//   $AppDatabaseManager get managers => $AppDatabaseManager(this);
//   late final $RayonTableTable rayonTable = $RayonTableTable(this);
//   late final $PelangganTableTable pelangganTable = $PelangganTableTable(this);
//   @override
//   Iterable<TableInfo<Table, Object?>> get allTables =>
//       allSchemaEntities.whereType<TableInfo<Table, Object?>>();
//   @override
//   List<DatabaseSchemaEntity> get allSchemaEntities => [
//     rayonTable,
//     pelangganTable,
//   ];
// }

// typedef $$RayonTableTableCreateCompanionBuilder =
//     RayonTableCompanion Function({
//       required String id,
//       required String nama,
//       required int total,
//       required int sudahTerbaca,
//       required int belumTerbaca,
//       Value<int> rowid,
//     });
// typedef $$RayonTableTableUpdateCompanionBuilder =
//     RayonTableCompanion Function({
//       Value<String> id,
//       Value<String> nama,
//       Value<int> total,
//       Value<int> sudahTerbaca,
//       Value<int> belumTerbaca,
//       Value<int> rowid,
//     });

// final class $$RayonTableTableReferences
//     extends BaseReferences<_$AppDatabase, $RayonTableTable, RayonTableData> {
//   $$RayonTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

//   static MultiTypedResultKey<$PelangganTableTable, List<PelangganTableData>>
//   _pelangganTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
//     db.pelangganTable,
//     aliasName: $_aliasNameGenerator(
//       db.rayonTable.id,
//       db.pelangganTable.rayonId,
//     ),
//   );

//   $$PelangganTableTableProcessedTableManager get pelangganTableRefs {
//     final manager = $$PelangganTableTableTableManager(
//       $_db,
//       $_db.pelangganTable,
//     ).filter((f) => f.rayonId.id.sqlEquals($_itemColumn<String>('id')!));

//     final cache = $_typedResult.readTableOrNull(_pelangganTableRefsTable($_db));
//     return ProcessedTableManager(
//       manager.$state.copyWith(prefetchedData: cache),
//     );
//   }
// }

// class $$RayonTableTableFilterComposer
//     extends Composer<_$AppDatabase, $RayonTableTable> {
//   $$RayonTableTableFilterComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnFilters<String> get id => $composableBuilder(
//     column: $table.id,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get nama => $composableBuilder(
//     column: $table.nama,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<int> get total => $composableBuilder(
//     column: $table.total,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<int> get sudahTerbaca => $composableBuilder(
//     column: $table.sudahTerbaca,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<int> get belumTerbaca => $composableBuilder(
//     column: $table.belumTerbaca,
//     builder: (column) => ColumnFilters(column),
//   );

//   Expression<bool> pelangganTableRefs(
//     Expression<bool> Function($$PelangganTableTableFilterComposer f) f,
//   ) {
//     final $$PelangganTableTableFilterComposer composer = $composerBuilder(
//       composer: this,
//       getCurrentColumn: (t) => t.id,
//       referencedTable: $db.pelangganTable,
//       getReferencedColumn: (t) => t.rayonId,
//       builder:
//           (
//             joinBuilder, {
//             $addJoinBuilderToRootComposer,
//             $removeJoinBuilderFromRootComposer,
//           }) => $$PelangganTableTableFilterComposer(
//             $db: $db,
//             $table: $db.pelangganTable,
//             $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
//             joinBuilder: joinBuilder,
//             $removeJoinBuilderFromRootComposer:
//                 $removeJoinBuilderFromRootComposer,
//           ),
//     );
//     return f(composer);
//   }
// }

// class $$RayonTableTableOrderingComposer
//     extends Composer<_$AppDatabase, $RayonTableTable> {
//   $$RayonTableTableOrderingComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnOrderings<String> get id => $composableBuilder(
//     column: $table.id,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get nama => $composableBuilder(
//     column: $table.nama,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<int> get total => $composableBuilder(
//     column: $table.total,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<int> get sudahTerbaca => $composableBuilder(
//     column: $table.sudahTerbaca,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<int> get belumTerbaca => $composableBuilder(
//     column: $table.belumTerbaca,
//     builder: (column) => ColumnOrderings(column),
//   );
// }

// class $$RayonTableTableAnnotationComposer
//     extends Composer<_$AppDatabase, $RayonTableTable> {
//   $$RayonTableTableAnnotationComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   GeneratedColumn<String> get id =>
//       $composableBuilder(column: $table.id, builder: (column) => column);

//   GeneratedColumn<String> get nama =>
//       $composableBuilder(column: $table.nama, builder: (column) => column);

//   GeneratedColumn<int> get total =>
//       $composableBuilder(column: $table.total, builder: (column) => column);

//   GeneratedColumn<int> get sudahTerbaca => $composableBuilder(
//     column: $table.sudahTerbaca,
//     builder: (column) => column,
//   );

//   GeneratedColumn<int> get belumTerbaca => $composableBuilder(
//     column: $table.belumTerbaca,
//     builder: (column) => column,
//   );

//   Expression<T> pelangganTableRefs<T extends Object>(
//     Expression<T> Function($$PelangganTableTableAnnotationComposer a) f,
//   ) {
//     final $$PelangganTableTableAnnotationComposer composer = $composerBuilder(
//       composer: this,
//       getCurrentColumn: (t) => t.id,
//       referencedTable: $db.pelangganTable,
//       getReferencedColumn: (t) => t.rayonId,
//       builder:
//           (
//             joinBuilder, {
//             $addJoinBuilderToRootComposer,
//             $removeJoinBuilderFromRootComposer,
//           }) => $$PelangganTableTableAnnotationComposer(
//             $db: $db,
//             $table: $db.pelangganTable,
//             $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
//             joinBuilder: joinBuilder,
//             $removeJoinBuilderFromRootComposer:
//                 $removeJoinBuilderFromRootComposer,
//           ),
//     );
//     return f(composer);
//   }
// }

// class $$RayonTableTableTableManager
//     extends
//         RootTableManager<
//           _$AppDatabase,
//           $RayonTableTable,
//           RayonTableData,
//           $$RayonTableTableFilterComposer,
//           $$RayonTableTableOrderingComposer,
//           $$RayonTableTableAnnotationComposer,
//           $$RayonTableTableCreateCompanionBuilder,
//           $$RayonTableTableUpdateCompanionBuilder,
//           (RayonTableData, $$RayonTableTableReferences),
//           RayonTableData,
//           PrefetchHooks Function({bool pelangganTableRefs})
//         > {
//   $$RayonTableTableTableManager(_$AppDatabase db, $RayonTableTable table)
//     : super(
//         TableManagerState(
//           db: db,
//           table: table,
//           createFilteringComposer: () =>
//               $$RayonTableTableFilterComposer($db: db, $table: table),
//           createOrderingComposer: () =>
//               $$RayonTableTableOrderingComposer($db: db, $table: table),
//           createComputedFieldComposer: () =>
//               $$RayonTableTableAnnotationComposer($db: db, $table: table),
//           updateCompanionCallback:
//               ({
//                 Value<String> id = const Value.absent(),
//                 Value<String> nama = const Value.absent(),
//                 Value<int> total = const Value.absent(),
//                 Value<int> sudahTerbaca = const Value.absent(),
//                 Value<int> belumTerbaca = const Value.absent(),
//                 Value<int> rowid = const Value.absent(),
//               }) => RayonTableCompanion(
//                 id: id,
//                 nama: nama,
//                 total: total,
//                 sudahTerbaca: sudahTerbaca,
//                 belumTerbaca: belumTerbaca,
//                 rowid: rowid,
//               ),
//           createCompanionCallback:
//               ({
//                 required String id,
//                 required String nama,
//                 required int total,
//                 required int sudahTerbaca,
//                 required int belumTerbaca,
//                 Value<int> rowid = const Value.absent(),
//               }) => RayonTableCompanion.insert(
//                 id: id,
//                 nama: nama,
//                 total: total,
//                 sudahTerbaca: sudahTerbaca,
//                 belumTerbaca: belumTerbaca,
//                 rowid: rowid,
//               ),
//           withReferenceMapper: (p0) => p0
//               .map(
//                 (e) => (
//                   e.readTable(table),
//                   $$RayonTableTableReferences(db, table, e),
//                 ),
//               )
//               .toList(),
//           prefetchHooksCallback: ({pelangganTableRefs = false}) {
//             return PrefetchHooks(
//               db: db,
//               explicitlyWatchedTables: [
//                 if (pelangganTableRefs) db.pelangganTable,
//               ],
//               addJoins: null,
//               getPrefetchedDataCallback: (items) async {
//                 return [
//                   if (pelangganTableRefs)
//                     await $_getPrefetchedData<
//                       RayonTableData,
//                       $RayonTableTable,
//                       PelangganTableData
//                     >(
//                       currentTable: table,
//                       referencedTable: $$RayonTableTableReferences
//                           ._pelangganTableRefsTable(db),
//                       managerFromTypedResult: (p0) =>
//                           $$RayonTableTableReferences(
//                             db,
//                             table,
//                             p0,
//                           ).pelangganTableRefs,
//                       referencedItemsForCurrentItem: (item, referencedItems) =>
//                           referencedItems.where((e) => e.rayonId == item.id),
//                       typedResults: items,
//                     ),
//                 ];
//               },
//             );
//           },
//         ),
//       );
// }

// typedef $$RayonTableTableProcessedTableManager =
//     ProcessedTableManager<
//       _$AppDatabase,
//       $RayonTableTable,
//       RayonTableData,
//       $$RayonTableTableFilterComposer,
//       $$RayonTableTableOrderingComposer,
//       $$RayonTableTableAnnotationComposer,
//       $$RayonTableTableCreateCompanionBuilder,
//       $$RayonTableTableUpdateCompanionBuilder,
//       (RayonTableData, $$RayonTableTableReferences),
//       RayonTableData,
//       PrefetchHooks Function({bool pelangganTableRefs})
//     >;
// typedef $$PelangganTableTableCreateCompanionBuilder =
//     PelangganTableCompanion Function({
//       required String id,
//       required String rayonId,
//       required String nama,
//       required String alamat,
//       required String noMeter,
//       Value<bool> sudahDibaca,
//       Value<DateTime?> tanggalBaca,
//       Value<String?> standMeter,
//       Value<String> status,
//       Value<int> rowid,
//     });
// typedef $$PelangganTableTableUpdateCompanionBuilder =
//     PelangganTableCompanion Function({
//       Value<String> id,
//       Value<String> rayonId,
//       Value<String> nama,
//       Value<String> alamat,
//       Value<String> noMeter,
//       Value<bool> sudahDibaca,
//       Value<DateTime?> tanggalBaca,
//       Value<String?> standMeter,
//       Value<String> status,
//       Value<int> rowid,
//     });

// final class $$PelangganTableTableReferences
//     extends
//         BaseReferences<
//           _$AppDatabase,
//           $PelangganTableTable,
//           PelangganTableData
//         > {
//   $$PelangganTableTableReferences(
//     super.$_db,
//     super.$_table,
//     super.$_typedResult,
//   );

//   static $RayonTableTable _rayonIdTable(_$AppDatabase db) =>
//       db.rayonTable.createAlias(
//         $_aliasNameGenerator(db.pelangganTable.rayonId, db.rayonTable.id),
//       );

//   $$RayonTableTableProcessedTableManager get rayonId {
//     final $_column = $_itemColumn<String>('rayon_id')!;

//     final manager = $$RayonTableTableTableManager(
//       $_db,
//       $_db.rayonTable,
//     ).filter((f) => f.id.sqlEquals($_column));
//     final item = $_typedResult.readTableOrNull(_rayonIdTable($_db));
//     if (item == null) return manager;
//     return ProcessedTableManager(
//       manager.$state.copyWith(prefetchedData: [item]),
//     );
//   }
// }

// class $$PelangganTableTableFilterComposer
//     extends Composer<_$AppDatabase, $PelangganTableTable> {
//   $$PelangganTableTableFilterComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnFilters<String> get id => $composableBuilder(
//     column: $table.id,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get nama => $composableBuilder(
//     column: $table.nama,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get alamat => $composableBuilder(
//     column: $table.alamat,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get noMeter => $composableBuilder(
//     column: $table.noMeter,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<bool> get sudahDibaca => $composableBuilder(
//     column: $table.sudahDibaca,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<DateTime> get tanggalBaca => $composableBuilder(
//     column: $table.tanggalBaca,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get standMeter => $composableBuilder(
//     column: $table.standMeter,
//     builder: (column) => ColumnFilters(column),
//   );

//   ColumnFilters<String> get status => $composableBuilder(
//     column: $table.status,
//     builder: (column) => ColumnFilters(column),
//   );

//   $$RayonTableTableFilterComposer get rayonId {
//     final $$RayonTableTableFilterComposer composer = $composerBuilder(
//       composer: this,
//       getCurrentColumn: (t) => t.rayonId,
//       referencedTable: $db.rayonTable,
//       getReferencedColumn: (t) => t.id,
//       builder:
//           (
//             joinBuilder, {
//             $addJoinBuilderToRootComposer,
//             $removeJoinBuilderFromRootComposer,
//           }) => $$RayonTableTableFilterComposer(
//             $db: $db,
//             $table: $db.rayonTable,
//             $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
//             joinBuilder: joinBuilder,
//             $removeJoinBuilderFromRootComposer:
//                 $removeJoinBuilderFromRootComposer,
//           ),
//     );
//     return composer;
//   }
// }

// class $$PelangganTableTableOrderingComposer
//     extends Composer<_$AppDatabase, $PelangganTableTable> {
//   $$PelangganTableTableOrderingComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnOrderings<String> get id => $composableBuilder(
//     column: $table.id,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get nama => $composableBuilder(
//     column: $table.nama,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get alamat => $composableBuilder(
//     column: $table.alamat,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get noMeter => $composableBuilder(
//     column: $table.noMeter,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<bool> get sudahDibaca => $composableBuilder(
//     column: $table.sudahDibaca,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<DateTime> get tanggalBaca => $composableBuilder(
//     column: $table.tanggalBaca,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get standMeter => $composableBuilder(
//     column: $table.standMeter,
//     builder: (column) => ColumnOrderings(column),
//   );

//   ColumnOrderings<String> get status => $composableBuilder(
//     column: $table.status,
//     builder: (column) => ColumnOrderings(column),
//   );

//   $$RayonTableTableOrderingComposer get rayonId {
//     final $$RayonTableTableOrderingComposer composer = $composerBuilder(
//       composer: this,
//       getCurrentColumn: (t) => t.rayonId,
//       referencedTable: $db.rayonTable,
//       getReferencedColumn: (t) => t.id,
//       builder:
//           (
//             joinBuilder, {
//             $addJoinBuilderToRootComposer,
//             $removeJoinBuilderFromRootComposer,
//           }) => $$RayonTableTableOrderingComposer(
//             $db: $db,
//             $table: $db.rayonTable,
//             $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
//             joinBuilder: joinBuilder,
//             $removeJoinBuilderFromRootComposer:
//                 $removeJoinBuilderFromRootComposer,
//           ),
//     );
//     return composer;
//   }
// }

// class $$PelangganTableTableAnnotationComposer
//     extends Composer<_$AppDatabase, $PelangganTableTable> {
//   $$PelangganTableTableAnnotationComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   GeneratedColumn<String> get id =>
//       $composableBuilder(column: $table.id, builder: (column) => column);

//   GeneratedColumn<String> get nama =>
//       $composableBuilder(column: $table.nama, builder: (column) => column);

//   GeneratedColumn<String> get alamat =>
//       $composableBuilder(column: $table.alamat, builder: (column) => column);

//   GeneratedColumn<String> get noMeter =>
//       $composableBuilder(column: $table.noMeter, builder: (column) => column);

//   GeneratedColumn<bool> get sudahDibaca => $composableBuilder(
//     column: $table.sudahDibaca,
//     builder: (column) => column,
//   );

//   GeneratedColumn<DateTime> get tanggalBaca => $composableBuilder(
//     column: $table.tanggalBaca,
//     builder: (column) => column,
//   );

//   GeneratedColumn<String> get standMeter => $composableBuilder(
//     column: $table.standMeter,
//     builder: (column) => column,
//   );

//   GeneratedColumn<String> get status =>
//       $composableBuilder(column: $table.status, builder: (column) => column);

//   $$RayonTableTableAnnotationComposer get rayonId {
//     final $$RayonTableTableAnnotationComposer composer = $composerBuilder(
//       composer: this,
//       getCurrentColumn: (t) => t.rayonId,
//       referencedTable: $db.rayonTable,
//       getReferencedColumn: (t) => t.id,
//       builder:
//           (
//             joinBuilder, {
//             $addJoinBuilderToRootComposer,
//             $removeJoinBuilderFromRootComposer,
//           }) => $$RayonTableTableAnnotationComposer(
//             $db: $db,
//             $table: $db.rayonTable,
//             $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
//             joinBuilder: joinBuilder,
//             $removeJoinBuilderFromRootComposer:
//                 $removeJoinBuilderFromRootComposer,
//           ),
//     );
//     return composer;
//   }
// }

// class $$PelangganTableTableTableManager
//     extends
//         RootTableManager<
//           _$AppDatabase,
//           $PelangganTableTable,
//           PelangganTableData,
//           $$PelangganTableTableFilterComposer,
//           $$PelangganTableTableOrderingComposer,
//           $$PelangganTableTableAnnotationComposer,
//           $$PelangganTableTableCreateCompanionBuilder,
//           $$PelangganTableTableUpdateCompanionBuilder,
//           (PelangganTableData, $$PelangganTableTableReferences),
//           PelangganTableData,
//           PrefetchHooks Function({bool rayonId})
//         > {
//   $$PelangganTableTableTableManager(
//     _$AppDatabase db,
//     $PelangganTableTable table,
//   ) : super(
//         TableManagerState(
//           db: db,
//           table: table,
//           createFilteringComposer: () =>
//               $$PelangganTableTableFilterComposer($db: db, $table: table),
//           createOrderingComposer: () =>
//               $$PelangganTableTableOrderingComposer($db: db, $table: table),
//           createComputedFieldComposer: () =>
//               $$PelangganTableTableAnnotationComposer($db: db, $table: table),
//           updateCompanionCallback:
//               ({
//                 Value<String> id = const Value.absent(),
//                 Value<String> rayonId = const Value.absent(),
//                 Value<String> nama = const Value.absent(),
//                 Value<String> alamat = const Value.absent(),
//                 Value<String> noMeter = const Value.absent(),
//                 Value<bool> sudahDibaca = const Value.absent(),
//                 Value<DateTime?> tanggalBaca = const Value.absent(),
//                 Value<String?> standMeter = const Value.absent(),
//                 Value<String> status = const Value.absent(),
//                 Value<int> rowid = const Value.absent(),
//               }) => PelangganTableCompanion(
//                 id: id,
//                 rayonId: rayonId,
//                 nama: nama,
//                 alamat: alamat,
//                 noMeter: noMeter,
//                 sudahDibaca: sudahDibaca,
//                 tanggalBaca: tanggalBaca,
//                 standMeter: standMeter,
//                 status: status,
//                 rowid: rowid,
//               ),
//           createCompanionCallback:
//               ({
//                 required String id,
//                 required String rayonId,
//                 required String nama,
//                 required String alamat,
//                 required String noMeter,
//                 Value<bool> sudahDibaca = const Value.absent(),
//                 Value<DateTime?> tanggalBaca = const Value.absent(),
//                 Value<String?> standMeter = const Value.absent(),
//                 Value<String> status = const Value.absent(),
//                 Value<int> rowid = const Value.absent(),
//               }) => PelangganTableCompanion.insert(
//                 id: id,
//                 rayonId: rayonId,
//                 nama: nama,
//                 alamat: alamat,
//                 noMeter: noMeter,
//                 sudahDibaca: sudahDibaca,
//                 tanggalBaca: tanggalBaca,
//                 standMeter: standMeter,
//                 status: status,
//                 rowid: rowid,
//               ),
//           withReferenceMapper: (p0) => p0
//               .map(
//                 (e) => (
//                   e.readTable(table),
//                   $$PelangganTableTableReferences(db, table, e),
//                 ),
//               )
//               .toList(),
//           prefetchHooksCallback: ({rayonId = false}) {
//             return PrefetchHooks(
//               db: db,
//               explicitlyWatchedTables: [],
//               addJoins:
//                   <
//                     T extends TableManagerState<
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic,
//                       dynamic
//                     >
//                   >(state) {
//                     if (rayonId) {
//                       state =
//                           state.withJoin(
//                                 currentTable: table,
//                                 currentColumn: table.rayonId,
//                                 referencedTable: $$PelangganTableTableReferences
//                                     ._rayonIdTable(db),
//                                 referencedColumn:
//                                     $$PelangganTableTableReferences
//                                         ._rayonIdTable(db)
//                                         .id,
//                               )
//                               as T;
//                     }

//                     return state;
//                   },
//               getPrefetchedDataCallback: (items) async {
//                 return [];
//               },
//             );
//           },
//         ),
//       );
// }

// typedef $$PelangganTableTableProcessedTableManager =
//     ProcessedTableManager<
//       _$AppDatabase,
//       $PelangganTableTable,
//       PelangganTableData,
//       $$PelangganTableTableFilterComposer,
//       $$PelangganTableTableOrderingComposer,
//       $$PelangganTableTableAnnotationComposer,
//       $$PelangganTableTableCreateCompanionBuilder,
//       $$PelangganTableTableUpdateCompanionBuilder,
//       (PelangganTableData, $$PelangganTableTableReferences),
//       PelangganTableData,
//       PrefetchHooks Function({bool rayonId})
//     >;

// class $AppDatabaseManager {
//   final _$AppDatabase _db;
//   $AppDatabaseManager(this._db);
//   $$RayonTableTableTableManager get rayonTable =>
//       $$RayonTableTableTableManager(_db, _db.rayonTable);
//   $$PelangganTableTableTableManager get pelangganTable =>
//       $$PelangganTableTableTableManager(_db, _db.pelangganTable);
// }
