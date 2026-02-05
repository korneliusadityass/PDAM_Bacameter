// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RayonTableTable extends RayonTable
    with TableInfo<$RayonTableTable, RayonTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RayonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idRayonMeta = const VerificationMeta(
    'idRayon',
  );
  @override
  late final GeneratedColumn<int> idRayon = GeneratedColumn<int>(
    'id_rayon',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaRayonMeta = const VerificationMeta(
    'namaRayon',
  );
  @override
  late final GeneratedColumn<String> namaRayon = GeneratedColumn<String>(
    'nama_rayon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalListMeta = const VerificationMeta(
    'totalList',
  );
  @override
  late final GeneratedColumn<int> totalList = GeneratedColumn<int>(
    'total_list',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalListTerbacaMeta = const VerificationMeta(
    'totalListTerbaca',
  );
  @override
  late final GeneratedColumn<int> totalListTerbaca = GeneratedColumn<int>(
    'total_list_terbaca',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalListBelumTerbacaMeta =
      const VerificationMeta('totalListBelumTerbaca');
  @override
  late final GeneratedColumn<int> totalListBelumTerbaca = GeneratedColumn<int>(
    'total_list_belum_terbaca',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    idRayon,
    namaRayon,
    totalList,
    totalListTerbaca,
    totalListBelumTerbaca,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rayon_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RayonTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_rayon')) {
      context.handle(
        _idRayonMeta,
        idRayon.isAcceptableOrUnknown(data['id_rayon']!, _idRayonMeta),
      );
    }
    if (data.containsKey('nama_rayon')) {
      context.handle(
        _namaRayonMeta,
        namaRayon.isAcceptableOrUnknown(data['nama_rayon']!, _namaRayonMeta),
      );
    } else if (isInserting) {
      context.missing(_namaRayonMeta);
    }
    if (data.containsKey('total_list')) {
      context.handle(
        _totalListMeta,
        totalList.isAcceptableOrUnknown(data['total_list']!, _totalListMeta),
      );
    }
    if (data.containsKey('total_list_terbaca')) {
      context.handle(
        _totalListTerbacaMeta,
        totalListTerbaca.isAcceptableOrUnknown(
          data['total_list_terbaca']!,
          _totalListTerbacaMeta,
        ),
      );
    }
    if (data.containsKey('total_list_belum_terbaca')) {
      context.handle(
        _totalListBelumTerbacaMeta,
        totalListBelumTerbaca.isAcceptableOrUnknown(
          data['total_list_belum_terbaca']!,
          _totalListBelumTerbacaMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idRayon};
  @override
  RayonTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RayonTableData(
      idRayon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_rayon'],
      )!,
      namaRayon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_rayon'],
      )!,
      totalList: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_list'],
      )!,
      totalListTerbaca: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_list_terbaca'],
      )!,
      totalListBelumTerbaca: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_list_belum_terbaca'],
      )!,
    );
  }

  @override
  $RayonTableTable createAlias(String alias) {
    return $RayonTableTable(attachedDatabase, alias);
  }
}

class RayonTableData extends DataClass implements Insertable<RayonTableData> {
  final int idRayon;
  final String namaRayon;
  final int totalList;
  final int totalListTerbaca;
  final int totalListBelumTerbaca;
  const RayonTableData({
    required this.idRayon,
    required this.namaRayon,
    required this.totalList,
    required this.totalListTerbaca,
    required this.totalListBelumTerbaca,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_rayon'] = Variable<int>(idRayon);
    map['nama_rayon'] = Variable<String>(namaRayon);
    map['total_list'] = Variable<int>(totalList);
    map['total_list_terbaca'] = Variable<int>(totalListTerbaca);
    map['total_list_belum_terbaca'] = Variable<int>(totalListBelumTerbaca);
    return map;
  }

  RayonTableCompanion toCompanion(bool nullToAbsent) {
    return RayonTableCompanion(
      idRayon: Value(idRayon),
      namaRayon: Value(namaRayon),
      totalList: Value(totalList),
      totalListTerbaca: Value(totalListTerbaca),
      totalListBelumTerbaca: Value(totalListBelumTerbaca),
    );
  }

  factory RayonTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RayonTableData(
      idRayon: serializer.fromJson<int>(json['idRayon']),
      namaRayon: serializer.fromJson<String>(json['namaRayon']),
      totalList: serializer.fromJson<int>(json['totalList']),
      totalListTerbaca: serializer.fromJson<int>(json['totalListTerbaca']),
      totalListBelumTerbaca: serializer.fromJson<int>(
        json['totalListBelumTerbaca'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idRayon': serializer.toJson<int>(idRayon),
      'namaRayon': serializer.toJson<String>(namaRayon),
      'totalList': serializer.toJson<int>(totalList),
      'totalListTerbaca': serializer.toJson<int>(totalListTerbaca),
      'totalListBelumTerbaca': serializer.toJson<int>(totalListBelumTerbaca),
    };
  }

  RayonTableData copyWith({
    int? idRayon,
    String? namaRayon,
    int? totalList,
    int? totalListTerbaca,
    int? totalListBelumTerbaca,
  }) => RayonTableData(
    idRayon: idRayon ?? this.idRayon,
    namaRayon: namaRayon ?? this.namaRayon,
    totalList: totalList ?? this.totalList,
    totalListTerbaca: totalListTerbaca ?? this.totalListTerbaca,
    totalListBelumTerbaca: totalListBelumTerbaca ?? this.totalListBelumTerbaca,
  );
  RayonTableData copyWithCompanion(RayonTableCompanion data) {
    return RayonTableData(
      idRayon: data.idRayon.present ? data.idRayon.value : this.idRayon,
      namaRayon: data.namaRayon.present ? data.namaRayon.value : this.namaRayon,
      totalList: data.totalList.present ? data.totalList.value : this.totalList,
      totalListTerbaca: data.totalListTerbaca.present
          ? data.totalListTerbaca.value
          : this.totalListTerbaca,
      totalListBelumTerbaca: data.totalListBelumTerbaca.present
          ? data.totalListBelumTerbaca.value
          : this.totalListBelumTerbaca,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RayonTableData(')
          ..write('idRayon: $idRayon, ')
          ..write('namaRayon: $namaRayon, ')
          ..write('totalList: $totalList, ')
          ..write('totalListTerbaca: $totalListTerbaca, ')
          ..write('totalListBelumTerbaca: $totalListBelumTerbaca')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idRayon,
    namaRayon,
    totalList,
    totalListTerbaca,
    totalListBelumTerbaca,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RayonTableData &&
          other.idRayon == this.idRayon &&
          other.namaRayon == this.namaRayon &&
          other.totalList == this.totalList &&
          other.totalListTerbaca == this.totalListTerbaca &&
          other.totalListBelumTerbaca == this.totalListBelumTerbaca);
}

class RayonTableCompanion extends UpdateCompanion<RayonTableData> {
  final Value<int> idRayon;
  final Value<String> namaRayon;
  final Value<int> totalList;
  final Value<int> totalListTerbaca;
  final Value<int> totalListBelumTerbaca;
  const RayonTableCompanion({
    this.idRayon = const Value.absent(),
    this.namaRayon = const Value.absent(),
    this.totalList = const Value.absent(),
    this.totalListTerbaca = const Value.absent(),
    this.totalListBelumTerbaca = const Value.absent(),
  });
  RayonTableCompanion.insert({
    this.idRayon = const Value.absent(),
    required String namaRayon,
    this.totalList = const Value.absent(),
    this.totalListTerbaca = const Value.absent(),
    this.totalListBelumTerbaca = const Value.absent(),
  }) : namaRayon = Value(namaRayon);
  static Insertable<RayonTableData> custom({
    Expression<int>? idRayon,
    Expression<String>? namaRayon,
    Expression<int>? totalList,
    Expression<int>? totalListTerbaca,
    Expression<int>? totalListBelumTerbaca,
  }) {
    return RawValuesInsertable({
      if (idRayon != null) 'id_rayon': idRayon,
      if (namaRayon != null) 'nama_rayon': namaRayon,
      if (totalList != null) 'total_list': totalList,
      if (totalListTerbaca != null) 'total_list_terbaca': totalListTerbaca,
      if (totalListBelumTerbaca != null)
        'total_list_belum_terbaca': totalListBelumTerbaca,
    });
  }

  RayonTableCompanion copyWith({
    Value<int>? idRayon,
    Value<String>? namaRayon,
    Value<int>? totalList,
    Value<int>? totalListTerbaca,
    Value<int>? totalListBelumTerbaca,
  }) {
    return RayonTableCompanion(
      idRayon: idRayon ?? this.idRayon,
      namaRayon: namaRayon ?? this.namaRayon,
      totalList: totalList ?? this.totalList,
      totalListTerbaca: totalListTerbaca ?? this.totalListTerbaca,
      totalListBelumTerbaca:
          totalListBelumTerbaca ?? this.totalListBelumTerbaca,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idRayon.present) {
      map['id_rayon'] = Variable<int>(idRayon.value);
    }
    if (namaRayon.present) {
      map['nama_rayon'] = Variable<String>(namaRayon.value);
    }
    if (totalList.present) {
      map['total_list'] = Variable<int>(totalList.value);
    }
    if (totalListTerbaca.present) {
      map['total_list_terbaca'] = Variable<int>(totalListTerbaca.value);
    }
    if (totalListBelumTerbaca.present) {
      map['total_list_belum_terbaca'] = Variable<int>(
        totalListBelumTerbaca.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RayonTableCompanion(')
          ..write('idRayon: $idRayon, ')
          ..write('namaRayon: $namaRayon, ')
          ..write('totalList: $totalList, ')
          ..write('totalListTerbaca: $totalListTerbaca, ')
          ..write('totalListBelumTerbaca: $totalListBelumTerbaca')
          ..write(')'))
        .toString();
  }
}

class $PelangganTableTable extends PelangganTable
    with TableInfo<$PelangganTableTable, PelangganTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PelangganTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idRayonMeta = const VerificationMeta(
    'idRayon',
  );
  @override
  late final GeneratedColumn<int> idRayon = GeneratedColumn<int>(
    'id_rayon',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rayon_table (id_rayon)',
    ),
  );
  static const VerificationMeta _idPelangganMeta = const VerificationMeta(
    'idPelanggan',
  );
  @override
  late final GeneratedColumn<int> idPelanggan = GeneratedColumn<int>(
    'id_pelanggan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alamatMeta = const VerificationMeta('alamat');
  @override
  late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
    'alamat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noMeterMeta = const VerificationMeta(
    'noMeter',
  );
  @override
  late final GeneratedColumn<String> noMeter = GeneratedColumn<String>(
    'no_meter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sudahDibacaMeta = const VerificationMeta(
    'sudahDibaca',
  );
  @override
  late final GeneratedColumn<bool> sudahDibaca = GeneratedColumn<bool>(
    'sudah_dibaca',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sudah_dibaca" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tanggalBacaMeta = const VerificationMeta(
    'tanggalBaca',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalBaca = GeneratedColumn<DateTime>(
    'tanggal_baca',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _standMeterMeta = const VerificationMeta(
    'standMeter',
  );
  @override
  late final GeneratedColumn<int> standMeter = GeneratedColumn<int>(
    'stand_meter',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusTeruploadMeta = const VerificationMeta(
    'statusTerupload',
  );
  @override
  late final GeneratedColumn<bool> statusTerupload = GeneratedColumn<bool>(
    'status_terupload',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("status_terupload" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idRayon,
    idPelanggan,
    nama,
    alamat,
    noMeter,
    sudahDibaca,
    tanggalBaca,
    standMeter,
    statusTerupload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pelanggan_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PelangganTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_rayon')) {
      context.handle(
        _idRayonMeta,
        idRayon.isAcceptableOrUnknown(data['id_rayon']!, _idRayonMeta),
      );
    } else if (isInserting) {
      context.missing(_idRayonMeta);
    }
    if (data.containsKey('id_pelanggan')) {
      context.handle(
        _idPelangganMeta,
        idPelanggan.isAcceptableOrUnknown(
          data['id_pelanggan']!,
          _idPelangganMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idPelangganMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('alamat')) {
      context.handle(
        _alamatMeta,
        alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta),
      );
    } else if (isInserting) {
      context.missing(_alamatMeta);
    }
    if (data.containsKey('no_meter')) {
      context.handle(
        _noMeterMeta,
        noMeter.isAcceptableOrUnknown(data['no_meter']!, _noMeterMeta),
      );
    } else if (isInserting) {
      context.missing(_noMeterMeta);
    }
    if (data.containsKey('sudah_dibaca')) {
      context.handle(
        _sudahDibacaMeta,
        sudahDibaca.isAcceptableOrUnknown(
          data['sudah_dibaca']!,
          _sudahDibacaMeta,
        ),
      );
    }
    if (data.containsKey('tanggal_baca')) {
      context.handle(
        _tanggalBacaMeta,
        tanggalBaca.isAcceptableOrUnknown(
          data['tanggal_baca']!,
          _tanggalBacaMeta,
        ),
      );
    }
    if (data.containsKey('stand_meter')) {
      context.handle(
        _standMeterMeta,
        standMeter.isAcceptableOrUnknown(data['stand_meter']!, _standMeterMeta),
      );
    }
    if (data.containsKey('status_terupload')) {
      context.handle(
        _statusTeruploadMeta,
        statusTerupload.isAcceptableOrUnknown(
          data['status_terupload']!,
          _statusTeruploadMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PelangganTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PelangganTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idRayon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_rayon'],
      )!,
      idPelanggan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_pelanggan'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      alamat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alamat'],
      )!,
      noMeter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}no_meter'],
      )!,
      sudahDibaca: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sudah_dibaca'],
      )!,
      tanggalBaca: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_baca'],
      ),
      standMeter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stand_meter'],
      ),
      statusTerupload: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}status_terupload'],
      )!,
    );
  }

  @override
  $PelangganTableTable createAlias(String alias) {
    return $PelangganTableTable(attachedDatabase, alias);
  }
}

class PelangganTableData extends DataClass
    implements Insertable<PelangganTableData> {
  final int id;
  final int idRayon;
  final int idPelanggan;
  final String nama;
  final String alamat;
  final String noMeter;
  final bool sudahDibaca;
  final DateTime? tanggalBaca;
  final int? standMeter;
  final bool statusTerupload;
  const PelangganTableData({
    required this.id,
    required this.idRayon,
    required this.idPelanggan,
    required this.nama,
    required this.alamat,
    required this.noMeter,
    required this.sudahDibaca,
    this.tanggalBaca,
    this.standMeter,
    required this.statusTerupload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_rayon'] = Variable<int>(idRayon);
    map['id_pelanggan'] = Variable<int>(idPelanggan);
    map['nama'] = Variable<String>(nama);
    map['alamat'] = Variable<String>(alamat);
    map['no_meter'] = Variable<String>(noMeter);
    map['sudah_dibaca'] = Variable<bool>(sudahDibaca);
    if (!nullToAbsent || tanggalBaca != null) {
      map['tanggal_baca'] = Variable<DateTime>(tanggalBaca);
    }
    if (!nullToAbsent || standMeter != null) {
      map['stand_meter'] = Variable<int>(standMeter);
    }
    map['status_terupload'] = Variable<bool>(statusTerupload);
    return map;
  }

  PelangganTableCompanion toCompanion(bool nullToAbsent) {
    return PelangganTableCompanion(
      id: Value(id),
      idRayon: Value(idRayon),
      idPelanggan: Value(idPelanggan),
      nama: Value(nama),
      alamat: Value(alamat),
      noMeter: Value(noMeter),
      sudahDibaca: Value(sudahDibaca),
      tanggalBaca: tanggalBaca == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalBaca),
      standMeter: standMeter == null && nullToAbsent
          ? const Value.absent()
          : Value(standMeter),
      statusTerupload: Value(statusTerupload),
    );
  }

  factory PelangganTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PelangganTableData(
      id: serializer.fromJson<int>(json['id']),
      idRayon: serializer.fromJson<int>(json['idRayon']),
      idPelanggan: serializer.fromJson<int>(json['idPelanggan']),
      nama: serializer.fromJson<String>(json['nama']),
      alamat: serializer.fromJson<String>(json['alamat']),
      noMeter: serializer.fromJson<String>(json['noMeter']),
      sudahDibaca: serializer.fromJson<bool>(json['sudahDibaca']),
      tanggalBaca: serializer.fromJson<DateTime?>(json['tanggalBaca']),
      standMeter: serializer.fromJson<int?>(json['standMeter']),
      statusTerupload: serializer.fromJson<bool>(json['statusTerupload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idRayon': serializer.toJson<int>(idRayon),
      'idPelanggan': serializer.toJson<int>(idPelanggan),
      'nama': serializer.toJson<String>(nama),
      'alamat': serializer.toJson<String>(alamat),
      'noMeter': serializer.toJson<String>(noMeter),
      'sudahDibaca': serializer.toJson<bool>(sudahDibaca),
      'tanggalBaca': serializer.toJson<DateTime?>(tanggalBaca),
      'standMeter': serializer.toJson<int?>(standMeter),
      'statusTerupload': serializer.toJson<bool>(statusTerupload),
    };
  }

  PelangganTableData copyWith({
    int? id,
    int? idRayon,
    int? idPelanggan,
    String? nama,
    String? alamat,
    String? noMeter,
    bool? sudahDibaca,
    Value<DateTime?> tanggalBaca = const Value.absent(),
    Value<int?> standMeter = const Value.absent(),
    bool? statusTerupload,
  }) => PelangganTableData(
    id: id ?? this.id,
    idRayon: idRayon ?? this.idRayon,
    idPelanggan: idPelanggan ?? this.idPelanggan,
    nama: nama ?? this.nama,
    alamat: alamat ?? this.alamat,
    noMeter: noMeter ?? this.noMeter,
    sudahDibaca: sudahDibaca ?? this.sudahDibaca,
    tanggalBaca: tanggalBaca.present ? tanggalBaca.value : this.tanggalBaca,
    standMeter: standMeter.present ? standMeter.value : this.standMeter,
    statusTerupload: statusTerupload ?? this.statusTerupload,
  );
  PelangganTableData copyWithCompanion(PelangganTableCompanion data) {
    return PelangganTableData(
      id: data.id.present ? data.id.value : this.id,
      idRayon: data.idRayon.present ? data.idRayon.value : this.idRayon,
      idPelanggan: data.idPelanggan.present
          ? data.idPelanggan.value
          : this.idPelanggan,
      nama: data.nama.present ? data.nama.value : this.nama,
      alamat: data.alamat.present ? data.alamat.value : this.alamat,
      noMeter: data.noMeter.present ? data.noMeter.value : this.noMeter,
      sudahDibaca: data.sudahDibaca.present
          ? data.sudahDibaca.value
          : this.sudahDibaca,
      tanggalBaca: data.tanggalBaca.present
          ? data.tanggalBaca.value
          : this.tanggalBaca,
      standMeter: data.standMeter.present
          ? data.standMeter.value
          : this.standMeter,
      statusTerupload: data.statusTerupload.present
          ? data.statusTerupload.value
          : this.statusTerupload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PelangganTableData(')
          ..write('id: $id, ')
          ..write('idRayon: $idRayon, ')
          ..write('idPelanggan: $idPelanggan, ')
          ..write('nama: $nama, ')
          ..write('alamat: $alamat, ')
          ..write('noMeter: $noMeter, ')
          ..write('sudahDibaca: $sudahDibaca, ')
          ..write('tanggalBaca: $tanggalBaca, ')
          ..write('standMeter: $standMeter, ')
          ..write('statusTerupload: $statusTerupload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idRayon,
    idPelanggan,
    nama,
    alamat,
    noMeter,
    sudahDibaca,
    tanggalBaca,
    standMeter,
    statusTerupload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PelangganTableData &&
          other.id == this.id &&
          other.idRayon == this.idRayon &&
          other.idPelanggan == this.idPelanggan &&
          other.nama == this.nama &&
          other.alamat == this.alamat &&
          other.noMeter == this.noMeter &&
          other.sudahDibaca == this.sudahDibaca &&
          other.tanggalBaca == this.tanggalBaca &&
          other.standMeter == this.standMeter &&
          other.statusTerupload == this.statusTerupload);
}

class PelangganTableCompanion extends UpdateCompanion<PelangganTableData> {
  final Value<int> id;
  final Value<int> idRayon;
  final Value<int> idPelanggan;
  final Value<String> nama;
  final Value<String> alamat;
  final Value<String> noMeter;
  final Value<bool> sudahDibaca;
  final Value<DateTime?> tanggalBaca;
  final Value<int?> standMeter;
  final Value<bool> statusTerupload;
  const PelangganTableCompanion({
    this.id = const Value.absent(),
    this.idRayon = const Value.absent(),
    this.idPelanggan = const Value.absent(),
    this.nama = const Value.absent(),
    this.alamat = const Value.absent(),
    this.noMeter = const Value.absent(),
    this.sudahDibaca = const Value.absent(),
    this.tanggalBaca = const Value.absent(),
    this.standMeter = const Value.absent(),
    this.statusTerupload = const Value.absent(),
  });
  PelangganTableCompanion.insert({
    this.id = const Value.absent(),
    required int idRayon,
    required int idPelanggan,
    required String nama,
    required String alamat,
    required String noMeter,
    this.sudahDibaca = const Value.absent(),
    this.tanggalBaca = const Value.absent(),
    this.standMeter = const Value.absent(),
    this.statusTerupload = const Value.absent(),
  }) : idRayon = Value(idRayon),
       idPelanggan = Value(idPelanggan),
       nama = Value(nama),
       alamat = Value(alamat),
       noMeter = Value(noMeter);
  static Insertable<PelangganTableData> custom({
    Expression<int>? id,
    Expression<int>? idRayon,
    Expression<int>? idPelanggan,
    Expression<String>? nama,
    Expression<String>? alamat,
    Expression<String>? noMeter,
    Expression<bool>? sudahDibaca,
    Expression<DateTime>? tanggalBaca,
    Expression<int>? standMeter,
    Expression<bool>? statusTerupload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idRayon != null) 'id_rayon': idRayon,
      if (idPelanggan != null) 'id_pelanggan': idPelanggan,
      if (nama != null) 'nama': nama,
      if (alamat != null) 'alamat': alamat,
      if (noMeter != null) 'no_meter': noMeter,
      if (sudahDibaca != null) 'sudah_dibaca': sudahDibaca,
      if (tanggalBaca != null) 'tanggal_baca': tanggalBaca,
      if (standMeter != null) 'stand_meter': standMeter,
      if (statusTerupload != null) 'status_terupload': statusTerupload,
    });
  }

  PelangganTableCompanion copyWith({
    Value<int>? id,
    Value<int>? idRayon,
    Value<int>? idPelanggan,
    Value<String>? nama,
    Value<String>? alamat,
    Value<String>? noMeter,
    Value<bool>? sudahDibaca,
    Value<DateTime?>? tanggalBaca,
    Value<int?>? standMeter,
    Value<bool>? statusTerupload,
  }) {
    return PelangganTableCompanion(
      id: id ?? this.id,
      idRayon: idRayon ?? this.idRayon,
      idPelanggan: idPelanggan ?? this.idPelanggan,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      noMeter: noMeter ?? this.noMeter,
      sudahDibaca: sudahDibaca ?? this.sudahDibaca,
      tanggalBaca: tanggalBaca ?? this.tanggalBaca,
      standMeter: standMeter ?? this.standMeter,
      statusTerupload: statusTerupload ?? this.statusTerupload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idRayon.present) {
      map['id_rayon'] = Variable<int>(idRayon.value);
    }
    if (idPelanggan.present) {
      map['id_pelanggan'] = Variable<int>(idPelanggan.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (alamat.present) {
      map['alamat'] = Variable<String>(alamat.value);
    }
    if (noMeter.present) {
      map['no_meter'] = Variable<String>(noMeter.value);
    }
    if (sudahDibaca.present) {
      map['sudah_dibaca'] = Variable<bool>(sudahDibaca.value);
    }
    if (tanggalBaca.present) {
      map['tanggal_baca'] = Variable<DateTime>(tanggalBaca.value);
    }
    if (standMeter.present) {
      map['stand_meter'] = Variable<int>(standMeter.value);
    }
    if (statusTerupload.present) {
      map['status_terupload'] = Variable<bool>(statusTerupload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PelangganTableCompanion(')
          ..write('id: $id, ')
          ..write('idRayon: $idRayon, ')
          ..write('idPelanggan: $idPelanggan, ')
          ..write('nama: $nama, ')
          ..write('alamat: $alamat, ')
          ..write('noMeter: $noMeter, ')
          ..write('sudahDibaca: $sudahDibaca, ')
          ..write('tanggalBaca: $tanggalBaca, ')
          ..write('standMeter: $standMeter, ')
          ..write('statusTerupload: $statusTerupload')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoryTableTable extends SearchHistoryTable
    with TableInfo<$SearchHistoryTableTable, SearchHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pelangganIdMeta = const VerificationMeta(
    'pelangganId',
  );
  @override
  late final GeneratedColumn<int> pelangganId = GeneratedColumn<int>(
    'pelanggan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pelanggan_table (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pelangganId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pelanggan_id')) {
      context.handle(
        _pelangganIdMeta,
        pelangganId.isAcceptableOrUnknown(
          data['pelanggan_id']!,
          _pelangganIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pelangganIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pelangganId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pelanggan_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SearchHistoryTableTable createAlias(String alias) {
    return $SearchHistoryTableTable(attachedDatabase, alias);
  }
}

class SearchHistoryTableData extends DataClass
    implements Insertable<SearchHistoryTableData> {
  final int id;
  final int pelangganId;
  final DateTime createdAt;
  const SearchHistoryTableData({
    required this.id,
    required this.pelangganId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pelanggan_id'] = Variable<int>(pelangganId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SearchHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryTableCompanion(
      id: Value(id),
      pelangganId: Value(pelangganId),
      createdAt: Value(createdAt),
    );
  }

  factory SearchHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      pelangganId: serializer.fromJson<int>(json['pelangganId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pelangganId': serializer.toJson<int>(pelangganId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SearchHistoryTableData copyWith({
    int? id,
    int? pelangganId,
    DateTime? createdAt,
  }) => SearchHistoryTableData(
    id: id ?? this.id,
    pelangganId: pelangganId ?? this.pelangganId,
    createdAt: createdAt ?? this.createdAt,
  );
  SearchHistoryTableData copyWithCompanion(SearchHistoryTableCompanion data) {
    return SearchHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      pelangganId: data.pelangganId.present
          ? data.pelangganId.value
          : this.pelangganId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryTableData(')
          ..write('id: $id, ')
          ..write('pelangganId: $pelangganId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pelangganId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryTableData &&
          other.id == this.id &&
          other.pelangganId == this.pelangganId &&
          other.createdAt == this.createdAt);
}

class SearchHistoryTableCompanion
    extends UpdateCompanion<SearchHistoryTableData> {
  final Value<int> id;
  final Value<int> pelangganId;
  final Value<DateTime> createdAt;
  const SearchHistoryTableCompanion({
    this.id = const Value.absent(),
    this.pelangganId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SearchHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required int pelangganId,
    this.createdAt = const Value.absent(),
  }) : pelangganId = Value(pelangganId);
  static Insertable<SearchHistoryTableData> custom({
    Expression<int>? id,
    Expression<int>? pelangganId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pelangganId != null) 'pelanggan_id': pelangganId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SearchHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<int>? pelangganId,
    Value<DateTime>? createdAt,
  }) {
    return SearchHistoryTableCompanion(
      id: id ?? this.id,
      pelangganId: pelangganId ?? this.pelangganId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pelangganId.present) {
      map['pelanggan_id'] = Variable<int>(pelangganId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('pelangganId: $pelangganId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RayonTableTable rayonTable = $RayonTableTable(this);
  late final $PelangganTableTable pelangganTable = $PelangganTableTable(this);
  late final $SearchHistoryTableTable searchHistoryTable =
      $SearchHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rayonTable,
    pelangganTable,
    searchHistoryTable,
  ];
}

typedef $$RayonTableTableCreateCompanionBuilder =
    RayonTableCompanion Function({
      Value<int> idRayon,
      required String namaRayon,
      Value<int> totalList,
      Value<int> totalListTerbaca,
      Value<int> totalListBelumTerbaca,
    });
typedef $$RayonTableTableUpdateCompanionBuilder =
    RayonTableCompanion Function({
      Value<int> idRayon,
      Value<String> namaRayon,
      Value<int> totalList,
      Value<int> totalListTerbaca,
      Value<int> totalListBelumTerbaca,
    });

final class $$RayonTableTableReferences
    extends BaseReferences<_$AppDatabase, $RayonTableTable, RayonTableData> {
  $$RayonTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PelangganTableTable, List<PelangganTableData>>
  _pelangganTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pelangganTable,
    aliasName: $_aliasNameGenerator(
      db.rayonTable.idRayon,
      db.pelangganTable.idRayon,
    ),
  );

  $$PelangganTableTableProcessedTableManager get pelangganTableRefs {
    final manager = $$PelangganTableTableTableManager($_db, $_db.pelangganTable)
        .filter(
          (f) => f.idRayon.idRayon.sqlEquals($_itemColumn<int>('id_rayon')!),
        );

    final cache = $_typedResult.readTableOrNull(_pelangganTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RayonTableTableFilterComposer
    extends Composer<_$AppDatabase, $RayonTableTable> {
  $$RayonTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idRayon => $composableBuilder(
    column: $table.idRayon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaRayon => $composableBuilder(
    column: $table.namaRayon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalList => $composableBuilder(
    column: $table.totalList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalListTerbaca => $composableBuilder(
    column: $table.totalListTerbaca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalListBelumTerbaca => $composableBuilder(
    column: $table.totalListBelumTerbaca,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pelangganTableRefs(
    Expression<bool> Function($$PelangganTableTableFilterComposer f) f,
  ) {
    final $$PelangganTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRayon,
      referencedTable: $db.pelangganTable,
      getReferencedColumn: (t) => t.idRayon,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PelangganTableTableFilterComposer(
            $db: $db,
            $table: $db.pelangganTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RayonTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RayonTableTable> {
  $$RayonTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idRayon => $composableBuilder(
    column: $table.idRayon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaRayon => $composableBuilder(
    column: $table.namaRayon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalList => $composableBuilder(
    column: $table.totalList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalListTerbaca => $composableBuilder(
    column: $table.totalListTerbaca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalListBelumTerbaca => $composableBuilder(
    column: $table.totalListBelumTerbaca,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RayonTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RayonTableTable> {
  $$RayonTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idRayon =>
      $composableBuilder(column: $table.idRayon, builder: (column) => column);

  GeneratedColumn<String> get namaRayon =>
      $composableBuilder(column: $table.namaRayon, builder: (column) => column);

  GeneratedColumn<int> get totalList =>
      $composableBuilder(column: $table.totalList, builder: (column) => column);

  GeneratedColumn<int> get totalListTerbaca => $composableBuilder(
    column: $table.totalListTerbaca,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalListBelumTerbaca => $composableBuilder(
    column: $table.totalListBelumTerbaca,
    builder: (column) => column,
  );

  Expression<T> pelangganTableRefs<T extends Object>(
    Expression<T> Function($$PelangganTableTableAnnotationComposer a) f,
  ) {
    final $$PelangganTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRayon,
      referencedTable: $db.pelangganTable,
      getReferencedColumn: (t) => t.idRayon,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PelangganTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pelangganTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RayonTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RayonTableTable,
          RayonTableData,
          $$RayonTableTableFilterComposer,
          $$RayonTableTableOrderingComposer,
          $$RayonTableTableAnnotationComposer,
          $$RayonTableTableCreateCompanionBuilder,
          $$RayonTableTableUpdateCompanionBuilder,
          (RayonTableData, $$RayonTableTableReferences),
          RayonTableData,
          PrefetchHooks Function({bool pelangganTableRefs})
        > {
  $$RayonTableTableTableManager(_$AppDatabase db, $RayonTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RayonTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RayonTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RayonTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idRayon = const Value.absent(),
                Value<String> namaRayon = const Value.absent(),
                Value<int> totalList = const Value.absent(),
                Value<int> totalListTerbaca = const Value.absent(),
                Value<int> totalListBelumTerbaca = const Value.absent(),
              }) => RayonTableCompanion(
                idRayon: idRayon,
                namaRayon: namaRayon,
                totalList: totalList,
                totalListTerbaca: totalListTerbaca,
                totalListBelumTerbaca: totalListBelumTerbaca,
              ),
          createCompanionCallback:
              ({
                Value<int> idRayon = const Value.absent(),
                required String namaRayon,
                Value<int> totalList = const Value.absent(),
                Value<int> totalListTerbaca = const Value.absent(),
                Value<int> totalListBelumTerbaca = const Value.absent(),
              }) => RayonTableCompanion.insert(
                idRayon: idRayon,
                namaRayon: namaRayon,
                totalList: totalList,
                totalListTerbaca: totalListTerbaca,
                totalListBelumTerbaca: totalListBelumTerbaca,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RayonTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pelangganTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pelangganTableRefs) db.pelangganTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pelangganTableRefs)
                    await $_getPrefetchedData<
                      RayonTableData,
                      $RayonTableTable,
                      PelangganTableData
                    >(
                      currentTable: table,
                      referencedTable: $$RayonTableTableReferences
                          ._pelangganTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RayonTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pelangganTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.idRayon == item.idRayon,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RayonTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RayonTableTable,
      RayonTableData,
      $$RayonTableTableFilterComposer,
      $$RayonTableTableOrderingComposer,
      $$RayonTableTableAnnotationComposer,
      $$RayonTableTableCreateCompanionBuilder,
      $$RayonTableTableUpdateCompanionBuilder,
      (RayonTableData, $$RayonTableTableReferences),
      RayonTableData,
      PrefetchHooks Function({bool pelangganTableRefs})
    >;
typedef $$PelangganTableTableCreateCompanionBuilder =
    PelangganTableCompanion Function({
      Value<int> id,
      required int idRayon,
      required int idPelanggan,
      required String nama,
      required String alamat,
      required String noMeter,
      Value<bool> sudahDibaca,
      Value<DateTime?> tanggalBaca,
      Value<int?> standMeter,
      Value<bool> statusTerupload,
    });
typedef $$PelangganTableTableUpdateCompanionBuilder =
    PelangganTableCompanion Function({
      Value<int> id,
      Value<int> idRayon,
      Value<int> idPelanggan,
      Value<String> nama,
      Value<String> alamat,
      Value<String> noMeter,
      Value<bool> sudahDibaca,
      Value<DateTime?> tanggalBaca,
      Value<int?> standMeter,
      Value<bool> statusTerupload,
    });

final class $$PelangganTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PelangganTableTable,
          PelangganTableData
        > {
  $$PelangganTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RayonTableTable _idRayonTable(_$AppDatabase db) =>
      db.rayonTable.createAlias(
        $_aliasNameGenerator(db.pelangganTable.idRayon, db.rayonTable.idRayon),
      );

  $$RayonTableTableProcessedTableManager get idRayon {
    final $_column = $_itemColumn<int>('id_rayon')!;

    final manager = $$RayonTableTableTableManager(
      $_db,
      $_db.rayonTable,
    ).filter((f) => f.idRayon.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idRayonTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SearchHistoryTableTable,
    List<SearchHistoryTableData>
  >
  _searchHistoryTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.searchHistoryTable,
        aliasName: $_aliasNameGenerator(
          db.pelangganTable.id,
          db.searchHistoryTable.pelangganId,
        ),
      );

  $$SearchHistoryTableTableProcessedTableManager get searchHistoryTableRefs {
    final manager = $$SearchHistoryTableTableTableManager(
      $_db,
      $_db.searchHistoryTable,
    ).filter((f) => f.pelangganId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _searchHistoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PelangganTableTableFilterComposer
    extends Composer<_$AppDatabase, $PelangganTableTable> {
  $$PelangganTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPelanggan => $composableBuilder(
    column: $table.idPelanggan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noMeter => $composableBuilder(
    column: $table.noMeter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sudahDibaca => $composableBuilder(
    column: $table.sudahDibaca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalBaca => $composableBuilder(
    column: $table.tanggalBaca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get standMeter => $composableBuilder(
    column: $table.standMeter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get statusTerupload => $composableBuilder(
    column: $table.statusTerupload,
    builder: (column) => ColumnFilters(column),
  );

  $$RayonTableTableFilterComposer get idRayon {
    final $$RayonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRayon,
      referencedTable: $db.rayonTable,
      getReferencedColumn: (t) => t.idRayon,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RayonTableTableFilterComposer(
            $db: $db,
            $table: $db.rayonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> searchHistoryTableRefs(
    Expression<bool> Function($$SearchHistoryTableTableFilterComposer f) f,
  ) {
    final $$SearchHistoryTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.searchHistoryTable,
      getReferencedColumn: (t) => t.pelangganId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SearchHistoryTableTableFilterComposer(
            $db: $db,
            $table: $db.searchHistoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PelangganTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PelangganTableTable> {
  $$PelangganTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPelanggan => $composableBuilder(
    column: $table.idPelanggan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noMeter => $composableBuilder(
    column: $table.noMeter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sudahDibaca => $composableBuilder(
    column: $table.sudahDibaca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalBaca => $composableBuilder(
    column: $table.tanggalBaca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get standMeter => $composableBuilder(
    column: $table.standMeter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get statusTerupload => $composableBuilder(
    column: $table.statusTerupload,
    builder: (column) => ColumnOrderings(column),
  );

  $$RayonTableTableOrderingComposer get idRayon {
    final $$RayonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRayon,
      referencedTable: $db.rayonTable,
      getReferencedColumn: (t) => t.idRayon,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RayonTableTableOrderingComposer(
            $db: $db,
            $table: $db.rayonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PelangganTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PelangganTableTable> {
  $$PelangganTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idPelanggan => $composableBuilder(
    column: $table.idPelanggan,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get alamat =>
      $composableBuilder(column: $table.alamat, builder: (column) => column);

  GeneratedColumn<String> get noMeter =>
      $composableBuilder(column: $table.noMeter, builder: (column) => column);

  GeneratedColumn<bool> get sudahDibaca => $composableBuilder(
    column: $table.sudahDibaca,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggalBaca => $composableBuilder(
    column: $table.tanggalBaca,
    builder: (column) => column,
  );

  GeneratedColumn<int> get standMeter => $composableBuilder(
    column: $table.standMeter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get statusTerupload => $composableBuilder(
    column: $table.statusTerupload,
    builder: (column) => column,
  );

  $$RayonTableTableAnnotationComposer get idRayon {
    final $$RayonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRayon,
      referencedTable: $db.rayonTable,
      getReferencedColumn: (t) => t.idRayon,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RayonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.rayonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> searchHistoryTableRefs<T extends Object>(
    Expression<T> Function($$SearchHistoryTableTableAnnotationComposer a) f,
  ) {
    final $$SearchHistoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.searchHistoryTable,
          getReferencedColumn: (t) => t.pelangganId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.searchHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PelangganTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PelangganTableTable,
          PelangganTableData,
          $$PelangganTableTableFilterComposer,
          $$PelangganTableTableOrderingComposer,
          $$PelangganTableTableAnnotationComposer,
          $$PelangganTableTableCreateCompanionBuilder,
          $$PelangganTableTableUpdateCompanionBuilder,
          (PelangganTableData, $$PelangganTableTableReferences),
          PelangganTableData,
          PrefetchHooks Function({bool idRayon, bool searchHistoryTableRefs})
        > {
  $$PelangganTableTableTableManager(
    _$AppDatabase db,
    $PelangganTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PelangganTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PelangganTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PelangganTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idRayon = const Value.absent(),
                Value<int> idPelanggan = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> alamat = const Value.absent(),
                Value<String> noMeter = const Value.absent(),
                Value<bool> sudahDibaca = const Value.absent(),
                Value<DateTime?> tanggalBaca = const Value.absent(),
                Value<int?> standMeter = const Value.absent(),
                Value<bool> statusTerupload = const Value.absent(),
              }) => PelangganTableCompanion(
                id: id,
                idRayon: idRayon,
                idPelanggan: idPelanggan,
                nama: nama,
                alamat: alamat,
                noMeter: noMeter,
                sudahDibaca: sudahDibaca,
                tanggalBaca: tanggalBaca,
                standMeter: standMeter,
                statusTerupload: statusTerupload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idRayon,
                required int idPelanggan,
                required String nama,
                required String alamat,
                required String noMeter,
                Value<bool> sudahDibaca = const Value.absent(),
                Value<DateTime?> tanggalBaca = const Value.absent(),
                Value<int?> standMeter = const Value.absent(),
                Value<bool> statusTerupload = const Value.absent(),
              }) => PelangganTableCompanion.insert(
                id: id,
                idRayon: idRayon,
                idPelanggan: idPelanggan,
                nama: nama,
                alamat: alamat,
                noMeter: noMeter,
                sudahDibaca: sudahDibaca,
                tanggalBaca: tanggalBaca,
                standMeter: standMeter,
                statusTerupload: statusTerupload,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PelangganTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({idRayon = false, searchHistoryTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (searchHistoryTableRefs) db.searchHistoryTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (idRayon) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.idRayon,
                                    referencedTable:
                                        $$PelangganTableTableReferences
                                            ._idRayonTable(db),
                                    referencedColumn:
                                        $$PelangganTableTableReferences
                                            ._idRayonTable(db)
                                            .idRayon,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (searchHistoryTableRefs)
                        await $_getPrefetchedData<
                          PelangganTableData,
                          $PelangganTableTable,
                          SearchHistoryTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PelangganTableTableReferences
                              ._searchHistoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PelangganTableTableReferences(
                                db,
                                table,
                                p0,
                              ).searchHistoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pelangganId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PelangganTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PelangganTableTable,
      PelangganTableData,
      $$PelangganTableTableFilterComposer,
      $$PelangganTableTableOrderingComposer,
      $$PelangganTableTableAnnotationComposer,
      $$PelangganTableTableCreateCompanionBuilder,
      $$PelangganTableTableUpdateCompanionBuilder,
      (PelangganTableData, $$PelangganTableTableReferences),
      PelangganTableData,
      PrefetchHooks Function({bool idRayon, bool searchHistoryTableRefs})
    >;
typedef $$SearchHistoryTableTableCreateCompanionBuilder =
    SearchHistoryTableCompanion Function({
      Value<int> id,
      required int pelangganId,
      Value<DateTime> createdAt,
    });
typedef $$SearchHistoryTableTableUpdateCompanionBuilder =
    SearchHistoryTableCompanion Function({
      Value<int> id,
      Value<int> pelangganId,
      Value<DateTime> createdAt,
    });

final class $$SearchHistoryTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SearchHistoryTableTable,
          SearchHistoryTableData
        > {
  $$SearchHistoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PelangganTableTable _pelangganIdTable(_$AppDatabase db) =>
      db.pelangganTable.createAlias(
        $_aliasNameGenerator(
          db.searchHistoryTable.pelangganId,
          db.pelangganTable.id,
        ),
      );

  $$PelangganTableTableProcessedTableManager get pelangganId {
    final $_column = $_itemColumn<int>('pelanggan_id')!;

    final manager = $$PelangganTableTableTableManager(
      $_db,
      $_db.pelangganTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pelangganIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SearchHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PelangganTableTableFilterComposer get pelangganId {
    final $$PelangganTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pelangganId,
      referencedTable: $db.pelangganTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PelangganTableTableFilterComposer(
            $db: $db,
            $table: $db.pelangganTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PelangganTableTableOrderingComposer get pelangganId {
    final $$PelangganTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pelangganId,
      referencedTable: $db.pelangganTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PelangganTableTableOrderingComposer(
            $db: $db,
            $table: $db.pelangganTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PelangganTableTableAnnotationComposer get pelangganId {
    final $$PelangganTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pelangganId,
      referencedTable: $db.pelangganTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PelangganTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pelangganTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistoryTableTable,
          SearchHistoryTableData,
          $$SearchHistoryTableTableFilterComposer,
          $$SearchHistoryTableTableOrderingComposer,
          $$SearchHistoryTableTableAnnotationComposer,
          $$SearchHistoryTableTableCreateCompanionBuilder,
          $$SearchHistoryTableTableUpdateCompanionBuilder,
          (SearchHistoryTableData, $$SearchHistoryTableTableReferences),
          SearchHistoryTableData,
          PrefetchHooks Function({bool pelangganId})
        > {
  $$SearchHistoryTableTableTableManager(
    _$AppDatabase db,
    $SearchHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pelangganId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoryTableCompanion(
                id: id,
                pelangganId: pelangganId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pelangganId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoryTableCompanion.insert(
                id: id,
                pelangganId: pelangganId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SearchHistoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pelangganId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pelangganId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pelangganId,
                                referencedTable:
                                    $$SearchHistoryTableTableReferences
                                        ._pelangganIdTable(db),
                                referencedColumn:
                                    $$SearchHistoryTableTableReferences
                                        ._pelangganIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SearchHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistoryTableTable,
      SearchHistoryTableData,
      $$SearchHistoryTableTableFilterComposer,
      $$SearchHistoryTableTableOrderingComposer,
      $$SearchHistoryTableTableAnnotationComposer,
      $$SearchHistoryTableTableCreateCompanionBuilder,
      $$SearchHistoryTableTableUpdateCompanionBuilder,
      (SearchHistoryTableData, $$SearchHistoryTableTableReferences),
      SearchHistoryTableData,
      PrefetchHooks Function({bool pelangganId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RayonTableTableTableManager get rayonTable =>
      $$RayonTableTableTableManager(_db, _db.rayonTable);
  $$PelangganTableTableTableManager get pelangganTable =>
      $$PelangganTableTableTableManager(_db, _db.pelangganTable);
  $$SearchHistoryTableTableTableManager get searchHistoryTable =>
      $$SearchHistoryTableTableTableManager(_db, _db.searchHistoryTable);
}
