import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../commons/extensions/context_extension.dart';
import '../../commons/routes/routes.dart';
import '../../commons/themes/text_styel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Biru
          _buildBackground(context),
      
          // content
          Positioned(
            top: context.height * 0.2 - 24, // 🔑 naik 24px
            left: 0,
            right: 0,
            child: _buildContent(context),
          ),
      
          // 🔥 RR BOX
          Positioned(
            top:
                context.height * 0.2 - 24 - 35, // 🔑 naik setengah tinggi box
            left: 16.w,
            child: Container(
              width: 80,
              height: 80,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: primary100,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 4, color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'RR',
                  style: TextStyle(
                    color: primary500Base,
                    fontSize: 28.sp,
                    fontFamily: 'Inter',
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ),
      
          // Powered By MKP
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Language.poweredBy,
                  style: TextStyle(
                    color: text700,
                    fontSize: 10.sp,
                    fontFamily: 'Inter',
                    fontWeight: semiBold,
                  ),
                ),
                verticalSpace(8.h),
                Image.asset(
                  'assets/icon/login/ic_logo_primary_mkp.png',
                  width: 85.w,
                  height: 24.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
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

  Widget _buildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 50.h, // 🔑 sesuai permintaan
        left: 16.w,
        right: 16.w,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rey Ronald',
            style: TextStyle(
              color: text700,
              fontSize: 20.sp,
              fontFamily: 'Inter',
              fontWeight: bold,
            ),
          ),
          verticalSpace(4.h),
          Text(
            'Petugas Pembaca Meter',
            style: TextStyle(
              color: text400,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: regular,
            ),
          ),
          verticalSpace(24.h),
          Text(
            Language.pengaturan,
            style: TextStyle(
              color: text400,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: medium,
            ),
          ),
          verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: borderDefault),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12.w,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(
                      0xFFFFEADA,
                    ) /* Color-System-color-Error-error-1 */,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Remix.delete_bin_6_fill,
                      color: error500,
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  Language.hapusHasilBaca,
                  style: TextStyle(
                    color: text700,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(24.h),
          GestureDetector(
            onTap: () {
              context.goNamed(Routes.loginPage);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: ShapeDecoration(
                color: error800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10.w,
                children: [
                  Icon(Remix.logout_box_line, color: baseWhite, size: 20),
                  Text(
                    Language.keluar,
                    style: TextStyle(
                      color: Colors.white,
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
    );
  }
}
