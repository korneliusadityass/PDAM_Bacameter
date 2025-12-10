import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/daftar_rayon/daftar_rayon_page.dart';
import 'package:baca_meter/core/presentation/page/home/feature/last_digit/last_digit_page.dart';
import 'package:baca_meter/core/presentation/page/home/feature/scan/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background utama
          Column(
            children: [
              // Header dengan background biru
              _buildHeader(),
              // Konten utama dengan rounded top - Expanded untuk mengisi sisa space
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          // Konten utama yang menumpuk di atas header
          Positioned(
            top: 155, // Sesuaikan dengan tinggi header yang diinginkan
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
              child: Column(
                children: [
                  // Persentase selesai
                  _buildCompletionPercentage(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(child: _buildRayonList()),
                        Expanded(child: _buildLastDigit()),
                        Expanded(child: _buildScan()),
                      ],
                    ),
                  ),
                  verticalSpace(20.h),
                ],
              ),
            ),
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16.0),
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
          // Bagian paling atas: Home
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.person, color: Colors.blue[700], size: 35),
              ),
              horizontalSpace(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rey Ronald',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Petugas Pembaca Meter',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(20.h),
          _buildReadingPeriod(),
        ],
      ),
    );
  }

  Widget _buildReadingPeriod() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: baseWhite.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: baseWhite.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, color: baseWhite, size: 10),
          horizontalSpace(10.w),
          Text(
            'Periode Pembacaan:',
            style: TextStyle(
              fontSize: 14.sp,
              color: baseWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          horizontalSpace(6.w),
          Text(
            'Oktober 2025',
            style: TextStyle(
              fontSize: 14.sp,
              color: baseWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionPercentage() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primary500Base.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary500Base.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Judul
          Text(
            'Laporan Produktivitas Pembaca',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: text900,
            ),
          ),
          const SizedBox(height: 12),
          // Semicircle Progress
          Stack(
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
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              _buildStatItem('Jumlah Pelanggan', '0'),
              const SizedBox(height: 8),
              _buildStatItem('Sudah Terbaca', '0'),
              const SizedBox(height: 8),
              _buildStatItem('Belum Terbaca', '0'),
              const SizedBox(height: 8),
              _buildStatItem('Belum Upload', '0'),
              const SizedBox(height: 8),
              _buildStatItem('Kelainan', '0'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: text900,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: text900,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DaftarRayonPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary500Base,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primary500Base),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Remix.database_2_fill, color: baseWhite, size: 32),
              ],
            ),
          ),
        ),
        verticalSpace(10.h),
        Text(
          'Daftar Rayon',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: text500Base,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LastDigitPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary500Base,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primary500Base),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.seo_fill, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(10.h),
        Text(
          'Last Digit',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: text500Base,
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
            // Tambahkan navigasi untuk scan di sini jika diperlukan
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary500Base,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primary500Base),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.qr_code_line, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(10.h),
        Text(
          'Scan',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: text500Base,
          ),
        ),
      ],
    );
  }
}
