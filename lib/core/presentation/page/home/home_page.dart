import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/constants.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:remixicon/remixicon.dart';

import '../../commons/extensions/context_extension.dart';
import '../../commons/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [_buildBackground(context), _buildContent(context)],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin.w,
            vertical: 16.h,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.person, color: Colors.blue[700], size: 35),
              ),
              horizontalSpace(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rey Ronald',
                    style: TextStyle(
                      color: Colors.white /* Color-Base-color-Text-Text-1 */,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: semiBold,
                    ),
                  ),
                  verticalSpace(4.h),
                  Text(
                    'Petugas Pembaca Meter',
                    style: TextStyle(
                      color: Colors.white /* Color-Base-color-Text-Text-1 */,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Periode Pembacaan
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: defaultMargin.w,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: ShapeDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: ShapeDecoration(
                    color:
                        Colors.white /* Color-Base-color-Background-Bg-white */,
                    shape: OvalBorder(),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Periode Pembacaan: ',
                        style: TextStyle(
                          color: Colors
                              .white /* Color-Base-color-Background-Bg-white */,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
                        ),
                      ),
                      TextSpan(
                        text: 'Oktober 2025',
                        style: TextStyle(
                          color: Colors
                              .white /* Color-Base-color-Background-Bg-white */,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Content
        Expanded(child: _content()),
      ],
    );
  }

  Widget _content() {
    return Container(
      // clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: EdgeInsets.only(
        // top: 24.h,
        left: 16.w,
        right: 16.w,
        // bottom: 16.h,
      ),
      decoration: ShapeDecoration(
        color: Colors.white /* Color-Base-color-Background-Bg-white */,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          verticalSpace(24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ), // EdgeInsets.all16),
            decoration: ShapeDecoration(
              color: const Color(
                0xFFF0F3FF,
              ) /* Color-Base-color-Background-Bg-sections */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Language.laporanProduktivitasPembaca,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F25),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: bold,
                  ),
                ),
                verticalSpace(24.h),
                Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.6, // 👈 POTONG TINGGI JADI SETENGAH
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background setengah lingkaran
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 12.0,
                        percent: 1.0,
                        arcType: ArcType.HALF,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressBorderColor: baseWhite,
                        progressColor: baseWhite.withValues(alpha: 0.3),
                        backgroundColor: Colors.transparent,
                      ),
                      // Progress sebenarnya
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 12.0,
                        percent: 0.62,
                        arcType: ArcType.HALF,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: primary500Base,
                        backgroundColor: Colors.transparent,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '62 %',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: text700,
                                fontSize: 28.sp,
                                fontFamily: 'Inter',
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              'Selesai',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: text400,
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(24.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatItem('Jumlah Pelanggan', '0'),
                    verticalSpace(12.h),
                    _buildStatItem('Sudah Terbaca', '0'),
                    verticalSpace(12.h),
                    _buildStatItem('Belum Terbaca', '0'),
                    verticalSpace(12.h),
                    _buildStatItem('Belum Upload', '0'),
                    verticalSpace(12.h),
                    _buildStatItem('Kelainan', '0'),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(24.h),
          // Daftar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildRayonList(), _buildLastDigit(), _buildScan()],
          ),
          verticalSpace(200.h),
        ],
      ),
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

  Widget _buildStatItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: medium,
            fontFamily: 'Inter',
            color: text700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: medium,
            fontFamily: 'Inter',
            color: text700,
          ),
        ),
      ],
    );
  }

  Widget _buildRayonList() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.daftarRayonPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Remix.database_2_fill, color: baseWhite, size: 32),
              ],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.daftarRayon,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
      ],
    );
  }

  Widget _buildLastDigit() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.lastDigitPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.seo_fill, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.lastDigit,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
      ],
    );
  }

  Widget _buildScan() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.scanPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.qr_code_line, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.scan,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
