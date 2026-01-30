import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../data/database/daftar_rayon/app_database.dart';
import '../../../../../../data/enum/database/database_status.dart';
import '../../../../../../data/injection/injection.dart';
import '../../../../../commons/extensions/context_extension.dart';
import '../../../../../commons/language/language.dart';
import '../../../../../commons/themes/constants.dart';
import '../../../../../commons/themes/text_styel.dart';
import '../../../../../manager/database_helper.dart';
import '../../../../../widget/button/normal_button.dart';

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
  List<PelangganTableData> _pelangganList = [];
  late final DatabaseHelper _dbHelper;
  // bool _isLoading = true;
  PageStatus? _status;
  String? _errorMessage;
  // bool _emptySearch = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _emptySearch = false;
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _dbHelper = sl<DatabaseHelper>();
    await _loadPelanggan();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadPelanggan() async {
    setState(() {
      _status = PageStatus.loading;
    });

    final result = await _dbHelper.getPelangganByRayon(
      int.parse(widget.rayonId),
    );

    result.fold(
      (failure) {
        setState(() {
          _status = PageStatus.error;
          _errorMessage = failure.message;
        });
      },
      (data) {
        setState(() {
          _pelangganList = data;
          // _emptySearch = false;
          _status = PageStatus.loaded;
        });
      },
    );
  }

  Future<void> _searchPelanggan(String query) async {
    if (query.isEmpty) {
      await _loadPelanggan();
      return;
    }

    setState(() {
      _status = PageStatus.loading;
    });

    final result = await _dbHelper.getPelangganByRayon(
      int.parse(widget.rayonId),
    );

    result.fold(
      (failure) {
        setState(() {
          _status = PageStatus.error;
          _errorMessage = failure.message;
        });
      },
      (pelanggans) {
        final queryLower = query.toLowerCase();
        final queryAsInt = int.tryParse(query);

        final filtered = pelanggans.where((pelanggan) {
          final matchNama = pelanggan.nama.toLowerCase().contains(queryLower);
          final matchId = queryAsInt != null && pelanggan.id == queryAsInt;

          return matchNama || matchId;
        }).toList();

        setState(() {
          // _emptySearch = filtered.isEmpty ? true : false;
          _pelangganList = filtered;
          _status = PageStatus.loaded;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget _buildContent(BuildContext context) {
    // kondisi jika keyboard terbuka
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 🔥 AREA BACKGROUND
        SizedBox(
          width: double.infinity,
          height: !isKeyboardOpen
              ? MediaQuery.of(context).size.height * 0.35
              : MediaQuery.of(context).size.height * 0.2,
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
                        Language.listPelanggan,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
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
                if (!isKeyboardOpen) ...[
                  verticalSpace(32.h),
                  _buildRayonSection(),
                ],
              ],
            ),
          ),
        ),
        Expanded(
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
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            child: _buildListPelanggan(),
          ),
        ),
      ],
    );
  }

  Widget _searchList() {
    return Positioned(
      bottom: 16.h,
      left: 16.w,
      right: 16.w,
      child: Column(children: [_buildSearchInputNew()]),
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
            height: height * 0.35,
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
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: ShapeDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rayonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  fontWeight: bold,
                ),
              ),
              verticalSpace(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.h,
                          padding: const EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF30B537),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              totalTerbaca.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(8.w),
                        Text(
                          'Terbaca',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(12.w),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.h,
                          padding: const EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFF5C49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              totalBelumTerbaca.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(8.w),
                        Text(
                          'Belum Terbaca',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: semiBold,
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
    );
  }

  Widget _buildListPelanggan() {
    switch (_status) {
      case PageStatus.loading:
        return _buildLoading();

      case PageStatus.error:
        return _buildError(
          _errorMessage ?? 'Terjadi kesalahan saat memuat data',
        );

      case PageStatus.loaded:
        return _pelangganList.isEmpty ? _buildEmpty() : _buildPelangganList();

      default:
        return _buildLoading();
    }
  }

  Widget _buildError(String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Feather.alert_triangle, size: 48.sp, color: error600),
          verticalSpace(8.h),
          Text(
            'Terjadi kesalahan',
            style: blackTextStyle.copyWith(color: error600, fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
          verticalSpace(8.h),
          NormalButton(
            width: 180.w,
            title: 'Coba Lagi',
            onPressed: () => _loadPelanggan(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Remix.search_line, size: 48, color: text400),
          verticalSpace(16.h),
          Text(
            'Tidak ada pelanggan yang ditemukan',
            style: TextStyle(
              fontSize: 14.sp,
              color: text400,
              fontFamily: 'Inter',
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPelangganList() {
    final pelanggans = _pelangganList;
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: pelanggans.length,

      separatorBuilder: (_, __) => verticalSpace(12.h),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == pelanggans.length - 1 ? 300.h : 0.h,
            top: index == 0 ? 12.h : 0.h,
          ),
          child: _buildListItemPelanggan(pelanggans[index]),
        );
      },
    );
  }

  Widget _buildListItemPelanggan(PelangganTableData pelanggan) {
    final status = pelanggan.sudahDibaca ? 'Terbaca' : 'Belum Terbaca';
    final isUploaded = pelanggan.sudahDibaca && pelanggan.statusTerupload;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon dengan warna berdasarkan status
                  Container(
                    padding: const EdgeInsets.all(6),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF0F3FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Icon(
                      Remix.home_6_fill,
                      color: status == 'Terbaca' ? success500 : primary500Base,
                      size: 24,
                    ),
                  ),

                  horizontalSpace(12.w),

                  // Konten utama
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.rayonName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: text400,
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: regular,
                              ),
                            ),
                            Text(
                              pelanggan.id.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: text700,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(4.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // // Nama Pelanggan
                                  Text(
                                    pelanggan.nama,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: text700,
                                      fontSize: 16.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: bold,
                                    ),
                                  ),
                                  verticalSpace(4.h),
                                  if (pelanggan.sudahDibaca &&
                                      pelanggan.standMeter != null) ...[
                                    Text(
                                      'Stand: ${pelanggan.standMeter}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: medium,
                                        color: success500,
                                      ),
                                    ),
                                  ] else ...[
                                    Text(
                                      'NK',
                                      style: TextStyle(
                                        color: text700,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            horizontalSpace(8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: ShapeDecoration(
                                color: status == 'Terbaca'
                                    ? success100
                                    : error100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: status == 'Terbaca'
                                      ? success500
                                      : error800,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
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
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: ShapeDecoration(
              color: baseBackgroundLight,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: borderDefault),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.circle, color: info800, size: 8),
                horizontalSpace(10.w),
                Text(
                  Language.uploaded,
                  style: TextStyle(
                    color: info800,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSearchInputNew() {
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
          _searchPelanggan(value);
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
          hintText: Language.cariPelanggan,
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
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    _searchController.clear();
                    await _loadPelanggan();
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

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: primary500Base),
          verticalSpace(16.h),
          Text(
            'Memuat data pelanggan...',
            style: TextStyle(
              fontSize: 14.sp,
              color: text400,
              fontFamily: 'Inter',
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
