import 'dart:io';

import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/golongan_bottom.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/mark_meter_bottom.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/memo_bottom.dart';
import 'package:baca_meter/core/presentation/widget/dashed/dased.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';

class DetailPelangganPage extends StatefulWidget {
  const DetailPelangganPage({super.key});

  @override
  State<DetailPelangganPage> createState() => _DetailPelangganPageState();
}

class _DetailPelangganPageState extends State<DetailPelangganPage> {
  bool _isKelainanExpanded = true;
  bool _isPerubahanAtributExpanded = true;
  bool _isRincianRekeningExpanded = true;

  File? _meteranImage;
  File? _rumahImage;

  File? _selectedMeteranImage;
  File? _selectedRumahImage;

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
              // Konten utama - Expanded untuk mengisi sisa space
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          // Konten utama yang menumpang di atas header — dibungkus GestureDetector
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 80.h,
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
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailPelanggan(),
                      verticalSpace(14.h),
                      _buildPemakaianSection(),
                      verticalSpace(14.h),
                      _buildKelainanSection(),
                      verticalSpace(14.h),
                      _buildPerubahanAtributSection(),
                      verticalSpace(14.h),
                      _buildRincianRekeningSection(),
                      verticalSpace(14.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // color: baseWhite,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: baseWhite,
                boxShadow: [
                  BoxShadow(
                    color: baseBlack.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: _buildSimpanButton(),
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

  Widget _buildSimpanButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: primary500Base,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Simpan Hasil Baca',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: baseWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
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
          verticalSpace(60.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Remix.arrow_left_line, color: baseWhite, size: 20),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Konfirmasi',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailPelanggan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Detail Pelanggan"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: primary100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                'Detail Pelanggan',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: primary500Base,
                ),
              ),
            ),
          ),

          verticalSpace(16.h),

          // Data Pelanggan
          _buildDataRow('Kode Pelanggan', '128290223'),
          _buildDataRow('Nama', 'Rey Ronald'),
          _buildDataRow('Alamat', 'BONTOMANAI'),
          _buildDataRow('Rayon / Gol', 'BONTOMANAI / NIAGA KECIL'),
          _buildDataRow('Total Tagihan', 'Rp. 0'),
        ],
      ),
    );
  }

  // Widget untuk membuat baris data
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: text500Base,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: text500Base,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPemakaianSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Pemakaian"
          Text(
            'Pemakaian',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: text500Base,
            ),
          ),

          verticalSpace(16.h),

          // Bulan ini
          _buildBulanSection('Bulan ini', '1323', '89,5%', '377 m³'),

          verticalSpace(12.h),

          // September 2025
          _buildBulanSection('September 2025', '1323', '89,5%', '377 m³'),

          verticalSpace(12.h),

          // Di bagian Meteran
          _buildPhotoSection(
            title: 'Meteran',
            subtitle: 'Ambil Foto Meteran',
            description: 'Maks 5Mb (PNG, JPG, JPEG, MP4)',
            selectedImage: _selectedMeteranImage, // Pass state gambar
            onImagePicked: (File? imageFile) {
              setState(() {
                _selectedMeteranImage = imageFile;
                _meteranImage =
                    imageFile; // Juga simpan di variabel utama jika diperlukan
              });
            },
          ),

          verticalSpace(12.h),

          // Di bagian Rumah
          _buildPhotoSection(
            title: 'Rumah',
            subtitle: 'Ambil Foto Rumah',
            description: 'Maks 5Mb (PNG, JPG, JPEG, MP4)',
            selectedImage: _selectedRumahImage, // Pass state gambar
            onImagePicked: (File? imageFile) {
              setState(() {
                _selectedRumahImage = imageFile;
                _rumahImage =
                    imageFile; // Juga simpan di variabel utama jika diperlukan
              });
            },
          ),

          verticalSpace(12.h),

          // Angka Stan
          _buildAngkaStanSection(),
        ],
      ),
    );
  }

  // Widget untuk bagian bulan (Bulan ini & September 2025)
  Widget _buildBulanSection(
    String title,
    String stan,
    String persen,
    String penggunaan,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: text500Base,
                ),
              ),
              Icon(Remix.calendar_2_line, size: 24, color: primary500Base),
            ],
          ),
          verticalSpace(8.h),
          _buildDivider(),
          verticalSpace(8.h),
          Row(
            children: [
              Expanded(child: _buildInfoItem('Stan', stan)),
              Expanded(child: _buildInfoItem('Persen', persen)),
              Expanded(child: _buildInfoItem('Penggunaan', penggunaan)),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk item info (Stan, Persen, Penggunaan)
  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: text400,
          ),
        ),
        verticalSpace(2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: text500Base,
          ),
        ),
      ],
    );
  }

  // Widget untuk bagian foto (Meteran & Rumah)
  Widget _buildPhotoSection({
    required String title,
    required String subtitle,
    required String description,
    required File? selectedImage, // Terima state gambar dari parent
    required Function(File?) onImagePicked,
  }) {
    Future<void> pickImage(ImageSource source) async {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: source,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 80,
        );

        if (pickedFile != null) {
          onImagePicked(File(pickedFile.path)); // Langsung panggil callback
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil gambar: $e'),
            backgroundColor: error600,
          ),
        );
      }
    }

    void showImageSourceDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih Sumber Gambar'),
            content: Text('Ambil foto dari:'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
                child: Text('Kamera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
                child: Text('Galeri'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Batal', style: TextStyle(color: error600)),
              ),
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label "Meteran *Required"
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: text500Base,
              ),
            ),
            horizontalSpace(4.w),
            Text(
              '*Required',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: error600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        verticalSpace(8.h),

        // Kotak Upload Foto
        GestureDetector(
          onTap: showImageSourceDialog,
          child: CustomPaint(
            size: Size(double.infinity, 130.h),
            painter: DottedBorderPainter(
              color: borderDark,
              strokeWidth: 2,
              dashWidth: 4,
              dashSpace: 4,
              borderRadius: 12.r,
            ),
            child: Container(
              width: double.infinity,
              height: 130.h,
              decoration: BoxDecoration(
                color: baseWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: selectedImage != null
                  ? _buildImagePreview(selectedImage)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ikon Kamera dalam lingkaran
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: baseSection,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Remix.camera_ai_fill,
                            size: 24,
                            color: primary500Base,
                          ),
                        ),
                        verticalSpace(8.h),

                        // Teks "Ambil Foto Meteran"
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3A8C),
                          ),
                        ),
                        verticalSpace(4.h),

                        // Teks info file
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF888888),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget untuk menampilkan preview gambar
  Widget _buildImagePreview(File imageFile) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            imageFile,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 88.h,
                color: baseSection,
                child: Center(
                  child: Icon(Remix.image_line, size: 32, color: text400),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: baseBackgroundLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Remix.delete_bin_5_fill, size: 20, color: error800),
          ),
        ),
      ],
    );
  }

  // Widget untuk bagian Angka Stan
  Widget _buildAngkaStanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Angka Stan',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
        verticalSpace(8.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: baseWhite,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderDark),
          ),
          child: Text(
            'Masukkan Angka Stan',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: text400,
            ),
          ),
        ),
      ],
    );
  }

  // Widget untuk garis pemisah (reuse dari sebelumnya)
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: borderDark.withValues(alpha: 0.5),
    );
  }

  Widget _buildKelainanSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Kelainan" dengan toggle
          GestureDetector(
            onTap: () {
              setState(() {
                _isKelainanExpanded = !_isKelainanExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kelainan',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: text500Base,
                  ),
                ),
                Icon(
                  _isKelainanExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: baseBlack,
                ),
              ],
            ),
          ),

          // Konten Kelainan (hanya ditampilkan jika expanded)
          if (_isKelainanExpanded) ...[
            verticalSpace(16.h),

            // Sub Judul "Kelainan"
            Text(
              'Kelainan',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: text500Base,
              ),
            ),

            verticalSpace(8.h),

            // Input Field Kelainan
            Container(
              width: double.infinity,
              height: 131.h,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: baseWhite,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: borderDark),
              ),
              child: Text(
                'Masukkan Kelainan',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: text400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPerubahanAtributSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Perubahan Atribut" dengan toggle
          GestureDetector(
            onTap: () {
              setState(() {
                _isPerubahanAtributExpanded = !_isPerubahanAtributExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Perubahan Atribut',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: text500Base,
                  ),
                ),
                Icon(
                  _isPerubahanAtributExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: baseBlack,
                ),
              ],
            ),
          ),

          // Konten Perubahan Atribut (hanya ditampilkan jika expanded)
          if (_isPerubahanAtributExpanded) ...[
            verticalSpace(16.h),

            // Bagian Memo pertama
            _buildMemoItem('Memo', 'Tidak Ada Data'),

            verticalSpace(12.h),

            // Bagian Golongan
            _buildAttributeItemGolongan('Golongan', 'SU'),

            verticalSpace(12.h),

            // Bagian MRK. Meter
            _buildAttributeItemMrkMeter('MRK. Meter', 'Ataris'),

            verticalSpace(8.h),
          ],
        ],
      ),
    );
  }

  // Widget untuk item Memo
  Widget _buildMemoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content.isEmpty ? 'Edit' : content,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: text400,
              ),
            ),
            GestureDetector(
              onTap: () {
                showEditMemoBottomSheet(context);
              },
              child: Container(
                width: 74.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: baseSection,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: borderDark),
                ),
                child: Center(
                  child: Text(
                    'Memo',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: primary500Base,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget untuk item atribut (Golongan, MRK. Meter)
  Widget _buildAttributeItemGolongan(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: text400,
              ),
            ),
            GestureDetector(
              onTap: () {
                showPilihGolonganBottomSheet(context);
              },
              child: Container(
                width: 92.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: baseSection,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: borderDark),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Remix.pencil_fill, size: 18, color: primary500Base),
                    horizontalSpace(4.w),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: primary500Base,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttributeItemMrkMeter(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: text400,
              ),
            ),
            GestureDetector(
              onTap: () {
                showPilihMrkMeterBottomSheet(context);
              },
              child: Container(
                width: 92.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: baseSection,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: borderDark),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Remix.pencil_fill, size: 18, color: primary500Base),
                    horizontalSpace(4.w),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: primary500Base,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRincianRekeningSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Rincian Rekening" dengan toggle
          GestureDetector(
            onTap: () {
              setState(() {
                _isRincianRekeningExpanded = !_isRincianRekeningExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rincian Rekening',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: text500Base,
                  ),
                ),
                Icon(
                  _isRincianRekeningExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: baseBlack,
                ),
              ],
            ),
          ),

          // Konten Rincian Rekening (hanya ditampilkan jika expanded)
          if (_isRincianRekeningExpanded) ...[
            verticalSpace(16.h),

            // List item rincian
            _buildRincianItem('Harga Air', 'Rp. 2.397.800'),
            _buildRincianItem('Administrasi', 'Rp. 2.500'),
            _buildRincianItem('Pemeliharaan', 'Rp. 3.500'),
            _buildRincianItem('Retribusi', 'Rp. 0'),
            _buildRincianItem('Pelayanan', 'Rp. 0'),
            _buildRincianItem('Air Limbah', 'Rp. 0'),
            _buildRincianItem('Materai', 'Rp. 0'),
            _buildDivider(),

            verticalSpace(12.h),

            // Total
            _buildTotalItem(),
          ],
        ],
      ),
    );
  }

  // Widget untuk item rincian
  Widget _buildRincianItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: text500Base,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: text500Base,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk total
  Widget _buildTotalItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
        Text(
          'Rp. 15.000',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: text500Base,
          ),
        ),
      ],
    );
  }

  void showEditMemoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditMemoBottomSheet(),
    );
  }

  void showPilihGolonganBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PilihGolonganBottomSheet(),
    );
  }

  void showPilihMrkMeterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PilihMrkMeterBottomSheet(),
    );
  }
}
