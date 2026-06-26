import 'dart:async';

import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../data/injection/injection.dart';
import '../../commons/extensions/context_extension.dart';
import '../../commons/themes/text_styel.dart';
import '../../manager/database_helper.dart';

class ManagementDataPage extends StatefulWidget {
  const ManagementDataPage({super.key});

  @override
  State<ManagementDataPage> createState() => _ManagementDataPageState();
}

class _ManagementDataPageState extends State<ManagementDataPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final DatabaseHelper _dbHelper;

  // === Animation Controllers ===
  late final AnimationController _animController;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _item1Slide;
  late final Animation<double> _item1Fade;
  late final Animation<Offset> _item2Slide;
  late final Animation<double> _item2Fade;
  late final Animation<Offset> _item3Slide;
  late final Animation<double> _item3Fade;

  @override
  void initState() {
    super.initState();
    _dbHelper = sl<DatabaseHelper>();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _titleFade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _item1Slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOutQuart),
    ));
    _item1Fade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeIn),
    );

    _item2Slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOutQuart),
    ));
    _item2Fade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    );

    _item3Slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOutQuart),
    ));
    _item3Fade = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> initDummy() async {
    final result = await _dbHelper.initDummyData();

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      (_) async {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data dummy berhasil diinisialisasi')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = context.width;
    final height = context.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(context, height, width),
          _buildContent(context, height),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context, double height, width) {
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

  Widget _buildContent(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 🔥 AREA BACKGROUND
        Expanded(
          flex: 2, // tinggi relatif (background)
          child: Center(
            child: FadeTransition(
              opacity: _titleFade,
              child: Text(
                Language.manajemenData,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: bold,
                ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransition(
                  position: _item1Slide,
                  child: FadeTransition(
                    opacity: _item1Fade,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Language.downloadPembacaan,
                          style: TextStyle(
                            color: text700,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: bold,
                          ),
                        ),
                        verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await _showDownloadDialog(context);
                                },
                                child: _buildDownloadMaster(context),
                              ),
                            ),
                            horizontalSpace(12.w),
                            Expanded(child: _buildDownloadBcUlang()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(24.w),
                SlideTransition(
                  position: _item2Slide,
                  child: FadeTransition(
                    opacity: _item2Fade,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Language.uploadDanExportData,
                          style: TextStyle(
                            color: text700,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: bold,
                          ),
                        ),
                        verticalSpace(16.h),
                        _buildUploadPembacaan(),
                      ],
                    ),
                  ),
                ),
                verticalSpace(16.h),
                SlideTransition(
                  position: _item3Slide,
                  child: FadeTransition(
                    opacity: _item3Fade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildImportDatabase()),
                        horizontalSpace(12.w),
                        Expanded(child: _buildExportDatabase()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPembacaan() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: baseSection,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        children: [
          // Judul
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  Language.uploadPembacaan,
                  style: TextStyle(
                    color: primary500Base,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: medium,
                  ),
                ),
              ),
              horizontalSpace(12.w),
              Icon(Remix.upload_cloud_2_fill, color: primary500Base, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadMaster(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: baseSection,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              Language.downloadMaster,
              style: TextStyle(
                color: primary500Base,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: medium,
              ),
            ),
          ),
          horizontalSpace(12.w),
          Icon(Remix.download_cloud_2_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Widget _buildDownloadBcUlang() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: baseSection,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Expanded(
            child: Text(
              Language.downloadBcUlang,
              style: TextStyle(
                color: primary500Base,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: medium,
              ),
            ),
          ),
          horizontalSpace(12.w),
          Icon(Remix.refresh_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Widget _buildImportDatabase() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: baseSection,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              Language.importDatabase,
              style: TextStyle(
                color: primary500Base,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: medium,
              ),
            ),
          ),
          horizontalSpace(12.w),
          Icon(Remix.upload_cloud_2_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Widget _buildExportDatabase() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(
          0xFFF0F3FF,
        ) /* Color-Base-color-Background-Bg-sections */,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              Language.exportDatabase,
              style: TextStyle(
                color: primary500Base,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: medium,
              ),
            ),
          ),
          horizontalSpace(12.w),
          Icon(Remix.download_cloud_2_fill, color: primary500Base, size: 24),
        ],
      ),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    // double progress = 0.0;
    // int currentSize = 0;
    // const int totalSize = 5000; // 5MB
    // Timer? timer;

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return StatefulBuilder(
    //       builder: (context, setState) {
    //         timer ??= Timer.periodic(const Duration(milliseconds: 100), (
    //           Timer t,
    //         ) {
    //           if (progress < 1.0) {
    //             setState(() {
    //               currentSize += 50;
    //               progress = currentSize / totalSize;
    //             });
    //           } else {
    //             t.cancel();
    //             Future.delayed(const Duration(seconds: 1), () {
    //               // ignore: use_build_context_synchronously
    //               Navigator.pop(context);
    //             });
    //           }
    //         });

    //         return AlertDialog(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.r),
    //           ),
    //           contentPadding:
    //               EdgeInsets.zero, // Penting: hilangkan padding default
    //           backgroundColor:
    //               Colors.transparent, // Agar tidak bentrok dengan container
    //           content: Container(
    //             width: double.infinity,
    //             decoration: ShapeDecoration(
    //               color:
    //                   Colors.white /* Color-Base-color-Background-Bg-white */,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(16),
    //               ),
    //             ),
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 16.w,
    //               vertical: 16.h,
    //             ), // internal padding konten
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Image.asset(
    //                   'assets/images/img_download_fix.webp',
    //                   height: 180.h,
    //                   width: 176.80,
    //                   // fit: BoxFit.contain,
    //                 ),
    //                 verticalSpace(16.h),
    //                 Text(
    //                   Language.downloading,
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 16.sp,
    //                     fontFamily: 'Inter',
    //                     fontWeight: bold,
    //                   ),
    //                 ),
    //                 verticalSpace(12.h),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Expanded(
    //                       child: LinearProgressIndicator(
    //                         value: progress,
    //                         backgroundColor: Colors.grey[200],
    //                         valueColor: AlwaysStoppedAnimation<Color>(
    //                           primary500Base,
    //                         ),
    //                         minHeight: 6.h,
    //                       ),
    //                     ),
    //                     horizontalSpace(8.w),
    //                     Text(
    //                       '${(progress * 100).toInt()}%',
    //                       style: TextStyle(
    //                         color: text700,
    //                         fontSize: 12.sp,
    //                         fontFamily: 'Inter',
    //                         fontWeight: semiBold,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 verticalSpace(12.h),
    //                 Text(
    //                   '${currentSize}Kb / ${totalSize}Kb',
    //                   style: TextStyle(
    //                     color: text400,
    //                     fontSize: 12.sp,
    //                     fontFamily: 'Inter',
    //                     fontWeight: medium,
    //                   ),
    //                 ),
    //                 verticalSpace(24.h),
    //                 TextButton(
    //                   onPressed: () {
    //                     timer?.cancel();
    //                     Navigator.pop(context);
    //                   },
    //                   child: Text(
    //                     Language.batalkan,
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                       color: error800,
    //                       fontSize: 14.sp,
    //                       fontFamily: 'Inter',
    //                       fontWeight: medium,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ).then((_) {
    //   timer?.cancel();
    // });

    final progressNotifier = ValueNotifier<double>(0.0);
    final sizeNotifier = ValueNotifier<int>(0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, _) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: _buildDownloadContent(progress, sizeNotifier.value),
            );
          },
        );
      },
    );

    /// 🔥 PENTING: tunggu dialog ter-render
    // await Future.delayed(Duration.zero);
    await Future.delayed(const Duration(milliseconds: 500));

    /// =========================
    /// JALANKAN PROSES SEBENARNYA
    /// =========================
    if (context.mounted) {
      await _runInitDummyWithProgress(context, progressNotifier, sizeNotifier);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  Future<void> _runInitDummyWithProgress(
    BuildContext context,
    ValueNotifier<double> progress,
    ValueNotifier<int> size,
  ) async {
    try {
      progress.value = 0.1;
      size.value = 500;

      final result = await _dbHelper.initDummyData();

      progress.value = 0.8;
      size.value = 4000;

      result.fold(
        (failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        },
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data dummy berhasil diinisialisasi')),
          );
        },
      );

      progress.value = 1.0;
      size.value = 5000;
    } catch (e) {
      progress.value = 1.0;
    }
  }

  Widget _buildDownloadContent(double progress, int currentSize) {
    const totalSize = 5000;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/img_download_fix.webp', height: 180.h),
          verticalSpace(16.h),
          Text(
            Language.downloading,
            style: TextStyle(fontSize: 16.sp, fontWeight: bold),
          ),
          verticalSpace(12.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6.h,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(primary500Base),
                ),
              ),
              horizontalSpace(8.w),
              Text('${(progress * 100).toInt()}%'),
            ],
          ),
          verticalSpace(12.h),
          Text('$currentSize Kb / $totalSize Kb'),
          verticalSpace(24.h),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
