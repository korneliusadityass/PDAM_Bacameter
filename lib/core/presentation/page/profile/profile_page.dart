import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseWhite,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Biru (Header)
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: primary500Base,
                image: const DecorationImage(
                  image: AssetImage('assets/icon/home/ic_appbar.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),

            // Konten Utama - di BELAKANG avatar
            Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: baseWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(40.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rev Ronald',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: text500Base,
                            ),
                          ),
                          verticalSpace(4.h),
                          Text(
                            'Petugas Pembaca Meter',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: text400,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(24.h),

                      Text(
                        'Pengaturan',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: text500Base,
                        ),
                      ),
                      verticalSpace(16.h),

                      // Tombol Hapus Data Hasil Baca
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: baseSection),
                        ),
                        child: Row(
                          children: [
                            // Container lingkaran untuk icon
                            Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: error100,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Remix.delete_bin_6_fill,
                                  color: error500,
                                  size: 18,
                                ),
                              ),
                            ),
                            horizontalSpace(12.w),
                            Text(
                              'Hapus Data Hasil Baca',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: text500Base,
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20.h),

                      // Tombol Keluar
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF7A66),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Remix.logout_box_line,
                              color: baseWhite,
                              size: 20,
                            ),
                            horizontalSpace(8.w),
                            Text(
                              'Keluar',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: text100,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacer untuk memberi ruang antara konten dan footer
                      Expanded(child: SizedBox.shrink()),

                      // Footer "Powered by MKP" - dengan margin bawah untuk menghindari navbar
                      Container(
                        margin: EdgeInsets.only(bottom: 80.h),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Powered by',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: text600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              verticalSpace(4.h),
                              Image.asset(
                                'assets/icon/login/ic_logo_primary_mkp.png',
                                width: 85.w,
                                height: 24.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(20.h),
                    ],
                  ),
                ),
              ),
            ),

            // Avatar "RR" - DI DEPAN konten utama
            Positioned(
              top: 80.h,
              left: 16.w,
              child: Container(
                width: 80.w,
                height: 80.h,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: baseWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: primary100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'RR',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: primary500Base,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
