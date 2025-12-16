import 'package:baca_meter/core/data/database/database.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/daftar_rayon/database/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/routes/routes.dart';

class DaftarRayonPage extends StatefulWidget {
  const DaftarRayonPage({super.key});

  @override
  State<DaftarRayonPage> createState() => _DaftarRayonPageState();
}

class _DaftarRayonPageState extends State<DaftarRayonPage>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late TabController _tabController;
  late RayonRepository _rayonRepository;
  List<RayonTableData> _rayonList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _rayonRepository = RayonRepository(AppDatabase());
    await _rayonRepository.initializeData();
    await _loadRayons();
  }

  Future<void> _loadRayons() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final rayons = await _rayonRepository.getAllRayons();
      setState(() {
        _rayonList = rayons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading rayons: $e');
    }
  }

  Future<void> _searchRayons(String query) async {
    if (query.isEmpty) {
      await _loadRayons();
    } else {
      try {
        final results = await _rayonRepository.searchRayons(query);
        setState(() {
          _rayonList = results;
        });
      } catch (e) {
        debugPrint('Error searching rayons: $e');
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<RayonTableData> get _filteredRayonList {
    if (_searchQuery.isEmpty) {
      return _rayonList;
    }
    return _rayonList.where((rayon) {
      final id = rayon.id.toLowerCase();
      final nama = rayon.nama.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return id.contains(query) || nama.contains(query);
    }).toList();
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
            top: 180.h,
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
                child: _buildRayonContent(),
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

  Widget _buildRayonContent() {
    if (_isLoading) {
      return _buildLoading();
    }
    return _filteredRayonList.isEmpty ? _buildEmpty() : _buildRayonList();
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
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
                    'Daftar Rayon',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: baseWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(20.h),
          _buildBaccanSection(),
        ],
      ),
    );
  }

  Widget _buildBaccanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          height: 56.h,
          decoration: BoxDecoration(
            color: primary700,
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: baseWhite,
              borderRadius: BorderRadius.circular(28.r),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: primary500Base,
            unselectedLabelColor: baseWhite,
            labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(text: 'Bacaan'),
              Tab(text: 'Bacaan Ulang'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRayonList() {
    final rayons = _filteredRayonList;

    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 80.h),
      itemCount: rayons.length,
      separatorBuilder: (_, __) =>
          Padding(padding: EdgeInsets.symmetric(vertical: 12.h)),
      itemBuilder: (context, index) {
        return _buildRayonItem(rayons[index]);
      },
    );
  }

  Widget _buildRayonItem(RayonTableData rayon) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         ListPelangganPage(rayonId: rayon.id, rayonName: rayon.nama),
        //   ),
        // );
        context.pushNamed(
          Routes.listPelangganPage,
          pathParameters: {'rayonId': rayon.id, 'rayonName': rayon.nama},
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: baseWhite,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderDark),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: baseSection,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: baseSection),
              ),
              child: Icon(Remix.folders_fill, color: primary500Base, size: 32),
            ),

            horizontalSpace(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rayon',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: text400,
                        ),
                      ),
                      Text(
                        'Pelanggan',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: text400,
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(4.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${rayon.id} - ${rayon.nama}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: text600,
                        ),
                      ),
                      Text(
                        rayon.total.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: text600,
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sudah Terbaca: ${rayon.sudahTerbaca}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: text600,
                        ),
                      ),
                      Text(
                        'Belum Terbaca: ${rayon.belumTerbaca}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: text600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              onChanged: (value) async {
                setState(() {
                  _searchQuery = value;
                });
                await _searchRayons(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari Rayon',
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
                await _loadRayons();
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
            'Memuat data...',
            style: TextStyle(fontSize: 14.sp, color: text400),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(40.h),
            Image.asset(
              'assets/images/img_empty_fix.png',
              width: 240.w,
              height: 240.h,
              fit: BoxFit.contain,
            ),
            verticalSpace(16.h),
            Text(
              'Data Belum Tersedia',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: text600,
              ),
            ),
            verticalSpace(8.h),
            Text(
              'Silahkan lakukan download master terlebih dahulu',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: text400),
            ),
            verticalSpace(24.h),
            GestureDetector(
              onTap: _loadRayons,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: primary500Base.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: primary500Base),
                ),
                child: Text(
                  'Download Master Sekarang',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: primary500Base,
                  ),
                ),
              ),
            ),
            verticalSpace(80.h),
          ],
        ),
      ),
    );
  }
}
