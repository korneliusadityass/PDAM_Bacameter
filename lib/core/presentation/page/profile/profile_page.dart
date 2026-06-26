import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../data/injection/injection.dart';
import '../../commons/extensions/context_extension.dart';
import '../../commons/routes/routes.dart';
import '../../commons/themes/text_styel.dart';
import '../../manager/database_helper.dart';
import '../../manager/shared_preferences_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final DatabaseHelper _dbHelper;

  // === Animation Controllers ===
  late final AnimationController _animController;
  late final Animation<double> _logoutScale;
  late final Animation<double> _logoutFade;
  late final Animation<double> _footerFade;
  late final Animation<Offset> _footerSlide;

  @override
  void initState() {
    super.initState();
    _dbHelper = sl<DatabaseHelper>();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Logout button: 0.0 - 0.6 (scale + fade)
    _logoutScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _logoutFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    // Footer: 0.4 - 1.0 (slide up + fade)
    _footerFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    _footerSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            top: context.height * 0.2 - 24 - 35, // 🔑 naik setengah tinggi box
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
            child: SlideTransition(
              position: _footerSlide,
              child: FadeTransition(
                opacity: _footerFade,
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
                      'assets/icon/login/ic_logo_primary_mkp.webp',
                      width: 85.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
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
                    'assets/icon/home/ic_appbar.webp',
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

  Future<void> resetData() async {
    if (mounted) showLoadingDialog(context);
    final result = await _dbHelper.deleteDataLocal();

    result.fold(
      (failure) {
        context.pop();
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      (_) async {
        context.pop();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data lokal berhasil dihapus')),
          );
        }
      },
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
          GestureDetector(
            onTap: () async => await resetData(),
            child: Container(
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
          ),
          verticalSpace(24.h),
          FadeTransition(
            opacity: _logoutFade,
            child: ScaleTransition(
              scale: _logoutScale,
              child: GestureDetector(
                onTap: () async {
                  await resetData();
                  await SharedPrefsHelper.logoutUser();
                  if (context.mounted) {
                    context.goNamed(Routes.loginPage);
                  }
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
