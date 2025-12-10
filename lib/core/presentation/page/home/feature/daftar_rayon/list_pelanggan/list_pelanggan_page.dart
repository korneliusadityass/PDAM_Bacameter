import 'package:baca_meter/core/data/database/database.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/daftar_rayon/database/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class ListPelangganPage extends StatefulWidget {
  final String rayonId;
  final String rayonName;

  const ListPelangganPage({
    super.key,
    required this.rayonId,
    required this.rayonName,
  });

  @override
  State<ListPelangganPage> createState() => _ListPelangganPageState();
}

class _ListPelangganPageState extends State<ListPelangganPage> {
  String _searchQuery = '';
  late RayonRepository _rayonRepository;
  List<PelangganTableData> _pelangganList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
    _loadPelanggan();
  }

  void _initializeRepository() {
    _rayonRepository = RayonRepository(AppDatabase());
  }

  Future<void> _loadPelanggan() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pelanggans = await _rayonRepository.getPelangganByRayon(
        widget.rayonId,
      );
      setState(() {
        _pelangganList = pelanggans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading pelanggan: $e');
    }
  }

  Future<void> _searchPelanggan(String query) async {
    if (query.isEmpty) {
      await _loadPelanggan();
    } else {
      // Untuk search yang lebih kompleks, bisa ditambahkan method search di repository
      final allPelanggans = await _rayonRepository.getPelangganByRayon(
        widget.rayonId,
      );
      setState(() {
        _pelangganList = allPelanggans.where((pelanggan) {
          final id = pelanggan.id.toLowerCase();
          final nama = pelanggan.nama.toLowerCase();
          final queryLower = query.toLowerCase();
          return id.contains(queryLower) || nama.contains(queryLower);
        }).toList();
      });
    }
  }

  List<PelangganTableData> get _filteredPelangganList {
    if (_searchQuery.isEmpty) {
      return _pelangganList;
    }
    return _pelangganList.where((pelanggan) {
      final id = pelanggan.id.toLowerCase();
      final nama = pelanggan.nama.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return id.contains(query) || nama.contains(query);
    }).toList();
  }

  // Helper method untuk menentukan status
  String _getStatus(PelangganTableData pelanggan) {
    return pelanggan.sudahDibaca ? 'Terbaca' : 'Belum Terbaca';
  }

  // Helper method untuk menentukan apakah sudah diupload
  bool _isUploaded(PelangganTableData pelanggan) {
    return pelanggan.sudahDibaca && pelanggan.status == 'SUDAH';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background utama
          Column(
            children: [
              // Header dengan background biru
              _buildHeader(context),
              // Area putih di bawah header
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          // Konten utama yang menumpang di atas header
          Positioned(
            top: 240.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: baseWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                child: _buildListPelanggan(),
              ),
            ),
          ),

          // Search Input Floating - di depan semua widget
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: _buildSearchInput(context),
          ),

          // SafeArea di atas stack untuk menghindari notch
          const SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary500Base,
        image: const DecorationImage(
          image: AssetImage('assets/icon/home/ic_appbar.png'),
          fit: BoxFit.contain,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          verticalSpace(40.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Remix.arrow_left_line, color: baseWhite, size: 20),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'List Pelanggan',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: baseWhite,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Icon(
                  Remix.upload_cloud_2_fill,
                  color: baseWhite,
                  size: 24,
                ),
              ),
            ],
          ),
          verticalSpace(20.h),
          _buildRayonSection(),
        ],
      ),
    );
  }

  Widget _buildRayonSection() {
    // Hitung total terbaca dan belum terbaca dari database
    int totalTerbaca = _pelangganList
        .where((pelanggan) => pelanggan.sudahDibaca)
        .length;
    int totalBelumTerbaca = _pelangganList
        .where((pelanggan) => !pelanggan.sudahDibaca)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: baseWhite.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rayonName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: baseWhite,
                ),
              ),
              verticalSpace(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: success500,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: success500),
                        ),
                        child: Center(
                          child: Text(
                            totalTerbaca.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: baseWhite,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10.w),
                      Text(
                        'Terbaca',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: baseWhite,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: error800,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: error800),
                        ),
                        child: Center(
                          child: Text(
                            totalBelumTerbaca.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: baseWhite,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10.w),
                      Text(
                        'Belum Terbaca',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: baseWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListPelanggan() {
    if (_isLoading) {
      return _buildLoading();
    }

    final pelanggans = _filteredPelangganList;

    if (pelanggans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Remix.search_line, size: 48, color: text400),
            verticalSpace(16.h),
            Text(
              'Tidak ada pelanggan yang ditemukan',
              style: TextStyle(fontSize: 14.sp, color: text400),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 80.h),
      itemCount: pelanggans.length,
      separatorBuilder: (_, __) =>
          Padding(padding: EdgeInsets.symmetric(vertical: 12.h)),
      itemBuilder: (context, index) {
        return _buildListItemPelanggan(pelanggans[index]);
      },
    );
  }

  Widget _buildListItemPelanggan(PelangganTableData pelanggan) {
    final status = _getStatus(pelanggan);
    final isUploaded = _isUploaded(pelanggan);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: baseWhite,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon dengan warna berdasarkan status
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: status == 'Terbaca' ? success100 : baseSection,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: status == 'Terbaca' ? success100 : baseSection,
                      ),
                    ),
                    child: Icon(
                      Remix.home_6_fill,
                      color: status == 'Terbaca' ? success500 : primary500Base,
                      size: 32,
                    ),
                  ),

                  horizontalSpace(12.w),

                  // Konten utama
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Rayon dan ID Pelanggan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.rayonName,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: text300,
                              ),
                            ),
                            Text(
                              pelanggan.id,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: text600,
                              ),
                            ),
                          ],
                        ),

                        verticalSpace(4.h),

                        // Nama Pelanggan
                        Text(
                          pelanggan.nama,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: text600,
                          ),
                        ),

                        verticalSpace(8.h),

                        // Status dengan badge dan info tambahan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Info stand meter jika sudah dibaca
                            if (pelanggan.sudahDibaca &&
                                pelanggan.standMeter != null)
                              Text(
                                'Stand: ${pelanggan.standMeter}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: success500,
                                ),
                              )
                            else
                              Text(
                                'NK',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: text600,
                                ),
                              ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: status == 'Terbaca'
                                    ? success100
                                    : error100,
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: status == 'Terbaca'
                                      ? success100
                                      : error100,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  horizontalSpace(4.w),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: status == 'Terbaca'
                                          ? success500
                                          : error800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isUploaded)
          Container(
            width: 316.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: baseBackgroundLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              border: Border(
                left: BorderSide(color: borderDefault),
                right: BorderSide(color: borderDefault),
                bottom: BorderSide(color: borderDefault),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.circle, color: info800, size: 10),
                horizontalSpace(4.w),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: info800,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return Container(
      height: 48.h,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
        boxShadow: [
          BoxShadow(
            color: baseBlack.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Remix.search_line, size: 18, color: text400),
          horizontalSpace(8.w),
          Expanded(
            child: TextField(
              onChanged: _searchPelanggan,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari Pelanggan',
                hintStyle: TextStyle(fontSize: 12.sp, color: text400),
              ),
              style: TextStyle(
                fontSize: 12.sp,
                color: text500Base,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () async {
                setState(() {
                  _searchQuery = '';
                });
                await _loadPelanggan();
              },
              child: Icon(Remix.close_line, size: 18, color: text400),
            ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: primary500Base),
          verticalSpace(16.h),
          Text(
            'Memuat data pelanggan...',
            style: TextStyle(fontSize: 14.sp, color: text400),
          ),
        ],
      ),
    );
  }
}
