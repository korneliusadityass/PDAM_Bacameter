import 'dart:async';

import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class ManagementDataPage extends StatelessWidget {
  const ManagementDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background utama
          Column(
            children: [
              // Header dengan background biru
              // verticalSpace(30.h),
              _buildHeader(),

              // Konten utama dengan rounded top - Expanded untuk mengisi sisa space
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          // Konten utama yang menumpuk di atas header
          Positioned(
            top: 70, // Sesuaikan dengan tinggi header yang diinginkan
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download Pembacaan',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: text500Base,
                      ),
                    ),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDownloadMaster(context),
                        _buildDownloadBcUlang(),
                      ],
                    ),

                    verticalSpace(20.h),
                    Text(
                      'Upload & Export Data',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: text500Base,
                      ),
                    ),
                    verticalSpace(20.h),
                    _buildUploadPembacaan(),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildImportDatabase(),
                        _buildExportDatabase(),
                      ],
                    ),
                  ],
                ),
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
      height: 180.h,
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
          verticalSpace(20.h),
          Text(
            'Management Data',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPembacaan() {
    return Container(
      width: 361.w,
      // margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: baseSection,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: baseSection),
      ),
      child: Column(
        children: [
          // Judul
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upload Pembacaan',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: primary500Base,
                ),
              ),
              Icon(Remix.upload_cloud_2_fill, color: primary500Base, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadMaster(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDownloadDialog(context);
      },
      child: Container(
        width: 165.w,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: baseSection,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: baseSection),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Download',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: primary500Base,
                    ),
                  ),
                  Text(
                    'Master',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: primary500Base,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Remix.download_cloud_2_fill, color: primary500Base, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadBcUlang() {
    return Container(
      width: 165.w,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: baseSection,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: baseSection),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Download BC',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
                Text(
                  'Ulang',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
              ],
            ),
          ),
          Icon(Remix.refresh_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Widget _buildImportDatabase() {
    return Container(
      width: 165.w,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: baseSection,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: baseSection),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Import',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
                Text(
                  'Database',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
              ],
            ),
          ),
          Icon(Remix.upload_cloud_2_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Widget _buildExportDatabase() {
    return Container(
      width: 165.w,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: baseSection,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: baseSection),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Export',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
                Text(
                  'Database',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: primary500Base,
                  ),
                ),
              ],
            ),
          ),
          Icon(Remix.download_cloud_2_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  void _showDownloadDialog(BuildContext context) {
    double progress = 0.0;
    int currentSize = 0;
    const int totalSize = 5000; // 5MB
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            timer ??= Timer.periodic(const Duration(milliseconds: 100), (
              Timer t,
            ) {
              if (progress < 1.0) {
                setState(() {
                  currentSize += 50;
                  progress = currentSize / totalSize;
                });
              } else {
                t.cancel();
                Future.delayed(const Duration(seconds: 1), () {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                });
              }
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              contentPadding:
                  EdgeInsets.zero, // Penting: hilangkan padding default
              backgroundColor:
                  Colors.transparent, // Agar tidak bentrok dengan container
              content: Container(
                width: 361.w,
                decoration: BoxDecoration(
                  color: baseWhite,
                  borderRadius: BorderRadius.circular(20.r),
                  // opsional: tambahkan shadow
                  // boxShadow: [
                  //   BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  // ],
                ),
                padding: const EdgeInsets.all(16.0), // internal padding konten
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/img_download_fix.png',
                      height: 150.h,
                      fit: BoxFit.contain,
                    ),
                    verticalSpace(16.h),
                    Text(
                      'Downloading',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: text500Base,
                      ),
                    ),
                    verticalSpace(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              primary500Base,
                            ),
                            minHeight: 6.h,
                          ),
                        ),
                        horizontalSpace(8.w),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: text500Base,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(8.h),
                    Text(
                      '${currentSize}Kb / ${totalSize}Kb',
                      style: TextStyle(fontSize: 12.sp, color: text500Base),
                    ),
                    verticalSpace(24.h),
                    TextButton(
                      onPressed: () {
                        timer?.cancel();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    verticalSpace(16.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      timer?.cancel();
    });
  }
}
