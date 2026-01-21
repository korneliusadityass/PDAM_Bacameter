import 'package:baca_meter/core/data/database/database.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/daftar_rayon/database/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/routes/routes.dart';
import '../../../../commons/themes/constants.dart';
import '../../../../commons/themes/text_styel.dart';

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

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

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
    _searchController.dispose();
    _searchFocusNode.dispose();
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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background utama
          _buildBackground(context),

          // Konten utama
          _buildContent(context),

          // Search Input dan Custom Keyboard Floating - dijadikan satu
          _searchList(),
        ],
      ),
    );
  }

  Widget _searchList() {
    return Positioned(
      bottom: 16.h,
      left: 16.w,
      right: 16.w,
      child: Column(
        children: [
          // _buildSearchInput(context)
          _buildBaccanSection(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 🔥 AREA BACKGROUND
        Expanded(
          flex: 3, // tinggi relatif (background)
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultMargin.w,
              top: 16.h,
              right: defaultMargin.w,
            ),
            child: Column(
              children: [
                verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Remix.arrow_left_line,
                        color: baseWhite,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Language.daftarRayon,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),

                /// ❌ HILANG SAAT KEYBOARD TERBUKA
                if (!isKeyboardOpen) ...[
                  const Spacer(),
                  _buildBaccanSectionNew(),
                  verticalSpace(16.h),
                ],
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7, // tinggi relatif (background)
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              // top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white /* Color-Base-color-Background-Bg-white */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            child: _buildRayonContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: height * 0.3,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: primary500Base),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/icon/home/ic_appbar.png',
                    width: width * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRayonContent() {
    if (_isLoading) {
      return _buildLoading();
    }
    return _filteredRayonList.isEmpty ? _buildEmpty() : _buildRayonList();
  }

  Widget _buildBaccanSectionNew() {
    return Column(
      children: [
        verticalSpace(16.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: primary700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x28000000),
                blurRadius: 4,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: primary500Base,
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            splashBorderRadius: BorderRadius.circular(24.r),
            tabs: [
              Tab(text: Language.bacaan),
              Tab(text: Language.bacaanUlang),
            ],
            indicator: BoxDecoration(
              // color: primary500Base,
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            labelColor: primary500Base,
            // labelColor: neutralColor1,
            unselectedLabelStyle: TextStyle(
              color: const Color(0xFFD5DAF9),
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: semiBold,
            ),

            unselectedLabelColor: baseWhite,
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: semiBold,
              fontFamily: 'Inter',
              color: const Color(0xFF2B3499),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBaccanSection() {
    return Material(
      color: Colors.transparent,
      elevation: 6, // setara blurRadius 4
      shadowColor: const Color(0x1E636363),
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _searchController,
        focusNode: _searchFocusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        onChanged: (value) async {
          setState(() {
            _searchQuery = value;
          });
          await _searchRayons(value);
        },

        onTapOutside: (_) => _searchFocusNode.unfocus(),

        style: TextStyle(
          color: text700,
          fontSize: 14.sp,
          fontFamily: 'Inter',
          fontWeight: medium,
        ),

        decoration: InputDecoration(
          isDense: true,
          hintText: Language.cariRayon,
          hintStyle: TextStyle(
            color: text300,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),

          // 🔥 Padding internal TextField
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),

          // 🔍 Icon kiri
          prefixIcon: Icon(Remix.search_line, size: 24, color: baseBlack),

          // ❌ Icon clear kanan
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    setState(() {
                      _searchQuery = '';
                    });
                    _searchController.clear();
                    await _loadRayons();
                  },
                  child: Icon(Remix.close_line, size: 24, color: baseBlack),
                )
              : null,

          // 🟦 Border normal
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderDefault),
          ),

          // 🟦 Border fokus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderDefault),
          ),

          // 🚫 Hilangkan error height tambahan
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderDefault),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderDefault),
          ),

          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    //       // height: 56.h,
    //       decoration: ShapeDecoration(
    //         color: primary700,
    //         // borderRadius: BorderRadius.circular(28.r),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(40),
    //         ),
    //         shadows: [
    //           BoxShadow(
    //             color: Color(0x28000000),
    //             blurRadius: 4,
    //             offset: Offset(0, 1),
    //             spreadRadius: 0,
    //           ),
    //         ],
    //       ),
    //       child: TabBar(
    //         controller: _tabController,
    //         dividerColor: Colors.transparent,
    //         indicator: BoxDecoration(
    //           color: baseWhite,
    //           borderRadius: BorderRadius.circular(28.r),
    //         ),
    //         indicatorSize: TabBarIndicatorSize.tab,
    //         labelColor: primary500Base,
    //         unselectedLabelColor: baseWhite,
    //         labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
    //         unselectedLabelStyle: TextStyle(
    //           fontSize: 12.sp,
    //           fontWeight: FontWeight.normal,
    //         ),
    //         tabs: [
    //           Tab(text: 'Bacaan'),
    //           Tab(text: 'Bacaan Ulang'),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildRayonList() {
    final rayons = _filteredRayonList;

    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      // padding: EdgeInsets.only(bottom: 80.h),
      itemCount: rayons.length,
      separatorBuilder: (_, __) => verticalSpace(12.h),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == rayons.length - 1 ? 300.h : 0.h,
            top: index == 0 ? 12.h : 0.h,
          ),
          child: _buildRayonItem(rayons[index]),
        );
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
          queryParameters: {'rayonId': rayon.id, 'rayonName': rayon.nama},
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: ShapeDecoration(
          color: Colors.white /* Color-Base-color-Background-Bg-white */,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(
                0xFFDBDBDB,
              ) /* Color-Base-color-Border-border-dark */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: baseSection,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: baseSection),
              ),
              child: Icon(Remix.folders_fill, color: primary500Base, size: 24),
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
                          color: text400,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        'Pelanggan',
                        style: TextStyle(
                          color: text400,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
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
                          color: text700,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        rayon.total.toString(),
                        style: TextStyle(
                          color: text700,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(16.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sudah Terbaca: ${rayon.sudahTerbaca}',
                        style: TextStyle(
                          color: text700,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Belum Terbaca: ${rayon.belumTerbaca}',
                        style: TextStyle(
                          color: text700,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: medium,
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
    return Center(
      child: ListView(
        children: [
          verticalSpace(16.h),
          Image.asset(
            'assets/images/img_empty_fix.png',
            width: 200.w,
            height: 200.h,
            fit: BoxFit.contain,
          ),
          verticalSpace(16.h),
          Text(
            'Data Belum Tersedia',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: text600,
              fontFamily: 'Inter',
            ),

            textAlign: TextAlign.center,
          ),
          verticalSpace(8.h),
          Text(
            'Silahkan lakukan download master terlebih dahulu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: text400,
              fontFamily: 'Inter',
            ),
          ),
          verticalSpace(16.h),
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
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          verticalSpace(300.h),
        ],
      ),
    );
  }
}
