import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../data/database/daftar_rayon/app_database.dart';
import '../../../../../data/injection/injection.dart';
import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/routes/routes.dart';
import '../../../../commons/themes/constants.dart';
import '../../../../commons/themes/text_styel.dart';
import '../../../../manager/database_helper.dart';

class DaftarRayonPage extends StatefulWidget {
  const DaftarRayonPage({super.key});

  @override
  State<DaftarRayonPage> createState() => _DaftarRayonPageState();
}

class _DaftarRayonPageState extends State<DaftarRayonPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<RayonTableData> _rayonList = [];
  late final DatabaseHelper _dbHelper;
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
    _dbHelper = sl<DatabaseHelper>();
    _loadRayons();
  }

  Future<void> _loadRayons() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _dbHelper.getAllRayons();
      setState(() {
        _rayonList = data;
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
        final result = await _dbHelper.searchRayons(query);
        setState(() {
          _rayonList = result;
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
    return _rayonList.isEmpty ? _buildEmpty() : _buildRayonList();
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
      elevation: 6, 
      shadowColor: const Color(0x1E636363),
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _searchController,
        focusNode: _searchFocusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        onChanged: (value) async {
          // setState(() {
          //   _searchQuery = value;
          // });
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
          // suffixIcon: _searchQuery.isNotEmpty
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    // setState(() {
                    //   _searchQuery = '';
                    // });
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
  }

  Widget _buildRayonList() {
    // final rayons = _filteredRayonList;
    final rayons = _rayonList;

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
        context.pushNamed(
          Routes.listPelangganPage,
          // queryParameters: {'rayonId': rayon.id, 'rayonName': rayon.nama},
          queryParameters: {
            'rayonId': rayon.idRayon.toString(),
            'rayonName': rayon.namaRayon,
          },
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
                        '${rayon.idRayon} - ${rayon.namaRayon}',
                        style: TextStyle(
                          color: text700,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        rayon.totalList.toString(),
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
                        'Sudah Terbaca: ${rayon.totalListTerbaca}',
                        style: TextStyle(
                          color: text700,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        'Belum Terbaca: ${rayon.totalListBelumTerbaca}',
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
            width: 178.w,
            height: 180.h,
            fit: BoxFit.contain,
          ),
          verticalSpace(16.h),
          Text(
            Language.dataBelumTersedia,
            style: TextStyle(
              color: text700,
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: semiBold,
            ),

            textAlign: TextAlign.center,
          ),
          verticalSpace(8.h),
          Text(
            Language.silahkanPilihPDAMTempatAndaBerkerjaTerlebihDahulu,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF131313),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
          verticalSpace(16.h),
          GestureDetector(
            onTap: () async {
              await _dbHelper.initDummyData();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: ShapeDecoration(
                color: const Color(
                  0xFFF0F3FF,
                ) ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                Language.downloadMasterSekarang,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary500Base,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
          verticalSpace(300.h),
        ],
      ),
    );
  }
}
