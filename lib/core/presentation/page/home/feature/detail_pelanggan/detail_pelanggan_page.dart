import 'dart:io';

import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/dialog_option.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/golongan_bottom.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/mark_meter_bottom.dart';
import 'package:baca_meter/core/presentation/page/home/feature/detail_pelanggan/widget/memo_bottom.dart';
import 'package:baca_meter/core/presentation/widget/dashed/dased.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/themes/constants.dart';
import '../../../../commons/themes/text_styel.dart';

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
          // // Konten utama yang menumpang di atas header — dibungkus GestureDetector
          // Positioned(
          //   top: 140,
          //   left: 0,
          //   right: 0,
          //   bottom: 80.h,
          //   child: Container(
          //     alignment: Alignment.topCenter,
          //     decoration: const BoxDecoration(
          //       color: baseWhite,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: SingleChildScrollView(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             _buildDetailPelanggan(),
          //             verticalSpace(14.h),
          //             _buildPemakaianSection(),
          //             verticalSpace(14.h),
          //             _buildKelainanSection(),
          //             verticalSpace(14.h),
          //             _buildPerubahanAtributSection(),
          //             verticalSpace(14.h),
          //             _buildRincianRekeningSection(),
          //             verticalSpace(14.h),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // Background utama
          _buildBackground(context),

          _buildContent(context),

          // Button Simpan
          _buildButtonSave(),
        ],
      ),
    );
  }

  Widget _buildButtonSave() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white /* Color-Base-color-Background-Bg-white */,
          boxShadow: [
            BoxShadow(
              color: Color(0x3364646F),
              blurRadius: 29,
              offset: Offset(0, 7),
              spreadRadius: 0,
            ),
          ],
        ),
        child: _buildSimpanButton(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 🔥 AREA BACKGROUND
        Expanded(
          flex: 2, // tinggi relatif (background)
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultMargin.w,
              top: defaultMargin.h,
              right: defaultMargin.w,
            ),
            child: Center(
              child: Row(
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
                      Language.konfirmasi,
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
            ),
          ),
        ),
        Expanded(
          flex: 8, // tinggi relatif (background)
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 24.h,
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailPelanggan(),
                  verticalSpace(16.h),
                  _buildPemakaianSection(),
                  verticalSpace(16.h),
                  _buildKelainanSection(),
                  verticalSpace(16.h),
                  _buildPerubahanAtributSection(),
                  verticalSpace(16.h),
                  _buildRincianRekeningSection(),
                  verticalSpace(150.h),
                ],
              ),
            ),
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
            height: height * 0.2,
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

  Widget _buildSimpanButton() {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: ShapeDecoration(
          color: primary600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          Language.simpanHasilBaca,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white /* Color-Base-color-Background-Bg-white */,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Detail Pelanggan"
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: ShapeDecoration(
              color: primary100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                'Detail Pelanggan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary500Base,
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  fontWeight: bold,
                ),
              ),
            ),
          ),

          verticalSpace(16.h),

          // Data Pelanggan
          _buildDataRow('Kode Pelanggan', '128290223'),
          verticalSpace(12.h),
          _buildDataRow('Nama', 'Rey Ronald'),
          verticalSpace(12.h),
          _buildDataRow('Alamat', 'BONTOMANAI'),
          verticalSpace(12.h),
          _buildDataRow('Rayon / Gol', 'BONTOMANAI / NIAGA KECIL'),
          verticalSpace(12.h),
          _buildDataRow('Total Tagihan', 'Rp. 0'),
        ],
      ),
    );
  }

  // Widget untuk membuat baris data
  Widget _buildDataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: text700,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: semiBold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: text700,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: regular,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPemakaianSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white /* Color-Base-color-Background-Bg-white */,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(
              0xFFE6E6E6,
            ) /* Color-Base-color-Border-border-default */,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "Pemakaian"
          Text(
            'Pemakaian',
            style: TextStyle(
              color: text700,
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: semiBold,
            ),
          ),

          verticalSpace(12.h),

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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(12),
        ),
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
                  color: text700,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: bold,
                ),
              ),
              Icon(Remix.calendar_2_line, size: 24, color: primary500Base),
            ],
          ),
          verticalSpace(12.h),
          // _buildDivider(),
          Divider(height: 1, thickness: 1, color: borderDefault),
          verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem('Stan', stan),
              _buildInfoItem('Persen', persen),
              _buildInfoItem('Penggunaan', penggunaan),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk item info (Stan, Persen, Penggunaan)
  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text400,
            fontSize: 12.sp,
            fontFamily: 'Inter',
            fontWeight: regular,
          ),
        ),
        verticalSpace(4.h),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: text700,
            fontSize: 16.sp,
            fontFamily: 'Inter',
            fontWeight: bold,
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
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Pilih Sumber Gambar',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  verticalSpace(8.h),

                  // Subtitle
                  const Text(
                    'Ambil foto dari:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  verticalSpace(20.h),

                  // Camera
                  DialogOption(
                    icon: Icons.camera_alt_outlined,
                    label: 'Kamera',
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                  ),

                  verticalSpace(12.h),

                  // Gallery
                  DialogOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Galeri',
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                  ),

                  verticalSpace(20.h),

                  // Cancel
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(foregroundColor: error600),
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                color: text700,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: regular,
              ),
            ),
            horizontalSpace(4.w),
            Text(
              '*Required',
              style: TextStyle(
                color: const Color(
                  0xFFDB3935,
                ) /* Color-System-color-Error-error-6 */,
                fontSize: 14.sp,
                fontStyle: FontStyle.italic,
                fontFamily: 'Inter',
                fontWeight: regular,
              ),
            ),
          ],
        ),
        verticalSpace(6.h),

        // Kotak Upload Foto
        GestureDetector(
          onTap: showImageSourceDialog,
          child: CustomPaint(
            // size: Size(double.infinity, 130.h),
            painter: DottedBorderPainter(
              color: borderDark,
              strokeWidth: 2,
              dashWidth: 4,
              dashSpace: 4,
              borderRadius: 12.r,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: borderDefault,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: selectedImage != null
                  ? _buildImagePreview(selectedImage)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ikon Kamera dalam lingkaran
                        Container(
                          width: 35.w,
                          height: 35.h,
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
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primary500Base,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: medium,
                          ),
                        ),
                        verticalSpace(8.h),

                        // Teks info file
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: text400,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: regular,
                          ),
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
          Language.angkaStan,
          style: TextStyle(
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
        verticalSpace(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: borderDefault,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            Language.masukkanAngkaStan,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: text300,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: regular,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(12),
        ),
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
                  Language.kelainan,
                  style: TextStyle(
                    color: text700,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: semiBold,
                  ),
                ),
                Icon(
                  _isKelainanExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: text500Base,
                ),
              ],
            ),
          ),

          // Konten Kelainan (hanya ditampilkan jika expanded)
          if (_isKelainanExpanded) ...[
            verticalSpace(16.h),

            // Sub Judul "Kelainan"
            Text(
              Language.kelainan,
              style: TextStyle(
                color: text700,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: medium,
              ),
            ),

            verticalSpace(8.h),

            // Input Field Kelainan
            Container(
              width: double.infinity,
              height: 131,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: borderDefault,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                Language.masukkanKelainan,
                style: TextStyle(
                  color: text300,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: regular,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(12),
        ),
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
                  Language.perubahanAtribut,
                  style: TextStyle(
                    color: text700,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: semiBold,
                  ),
                ),
                Icon(
                  _isPerubahanAtributExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: text500Base,
                ),
              ],
            ),
          ),

          // Konten Perubahan Atribut (hanya ditampilkan jika expanded)
          if (_isPerubahanAtributExpanded) ...[
            verticalSpace(16.h),

            // Bagian Memo pertama
            _buildMemoItem('Memo', 'Tidak Ada Data'),

            verticalSpace(8.h),

            // Bagian Golongan
            _buildAttributeItemGolongan('Golongan', 'SU'),

            verticalSpace(8.h),

            // Bagian MRK. Meter
            _buildAttributeItemMrkMeter('MRK. Meter', 'Ataris'),

            // _buildAttributeItemGolongan('MRK. Meter', 'SU'),
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
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                content.isEmpty ? 'Tidak Ada Data' : content,
                style: TextStyle(
                  color: text400,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: regular,
                ),
              ),
            ),
            horizontalSpace(6.w),
            GestureDetector(
              onTap: () {
                showEditMemoBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: ShapeDecoration(
                  color: baseSection,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  Language.memo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary500Base,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: medium,
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
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: text400,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: regular,
                ),
              ),
            ),
            horizontalSpace(6.w),
            GestureDetector(
              onTap: () {
                showPilihGolonganBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: ShapeDecoration(
                  color: baseSection,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Remix.pencil_fill, size: 24, color: primary500Base),
                    horizontalSpace(10.w),
                    Text(
                      Language.edit,
                      style: TextStyle(
                        color: primary500Base,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: medium,
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
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
        verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: text400,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: regular,
                ),
              ),
            ),
            horizontalSpace(6.w),
            GestureDetector(
              onTap: () {
                showPilihMrkMeterBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: ShapeDecoration(
                  color: baseSection,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Remix.pencil_fill, size: 24, color: primary500Base),
                    horizontalSpace(10.w),
                    Text(
                      Language.edit,
                      style: TextStyle(
                        color: primary500Base,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: medium,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(12),
        ),
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
                    color: text700,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: semiBold,
                  ),
                ),
                Icon(
                  _isRincianRekeningExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 24,
                  color: text500Base,
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
            verticalSpace(16.h),

            // _buildDivider(),
            Divider(height: 1, thickness: 1, color: borderDefault),
            verticalSpace(16.h),

            // Total
            _buildTotalItem(),
          ],
        ],
      ),
    );
  }

  // Widget untuk item rincian
  Widget _buildRincianItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: text700,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
        Text(
          value,
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

  // Widget untuk total
  Widget _buildTotalItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total',
          style: TextStyle(
            color: text700,
            fontSize: 20.sp,
            fontFamily: 'Inter',
            fontWeight: bold,
          ),
        ),
        Text(
          'Rp. 15.000',
          style: TextStyle(
            color: text700,
            fontSize: 20.sp,
            fontFamily: 'Inter',
            fontWeight: bold,
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
