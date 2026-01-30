import 'dart:async';
import 'dart:convert';

import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/routes/routes.dart';
import '../../../../commons/themes/constants.dart';
import '../../../../commons/themes/text_styel.dart';
import '../../../../widget/loading/loading_widget.dart';
import '../../../../widget/shimmer/shimmer_widget.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  MobileScannerController? controller;
  StreamSubscription<BarcodeCapture>? subscription;
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  String? lastScannedCode;
  DateTime? lastScanTime;
  final scanCooldown = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    controller = initController();
    unawaited(controller!.start());

    lastScannedCode = null;
    lastScanTime = null;

    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // 🔁 atas ↔ bawah

    _scanLineAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );

    _fetchInitialData();
  }

  MobileScannerController initController() => MobileScannerController(
    autoStart: false,
    cameraResolution: const Size(1920, 1080),
    detectionSpeed: DetectionSpeed.noDuplicates,
    detectionTimeoutMs: 1000,
    formats: [BarcodeFormat.qrCode],
    returnImage: false,
    torchEnabled: false,
    invertImage: false,
    autoZoom: false,
    facing: CameraFacing.back,
  );

  void _fetchInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // final homeNotifier = context.read<HomeNotifier>();
        // final infoAccounts = homeNotifier.getInfoAccountResponse;
        // final accounts = infoAccounts.result ?? [];
        // final isAvailableBina = accounts.any(
        //   (account) => account.digitalSavingAccountTypeId == 2,
        // );

        // if (accounts.length > 1 && isAvailableBina) {
        //   context.read<ScanQrProvider>().setSelectedAccount(
        //     homeNotifier.getWalletBankIna!,
        //   );
        // }
      }
    });
  }

  @override
  void dispose() async {
    _scanLineController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    await controller?.dispose();
    controller = null;
    subscription?.cancel();

    lastScannedCode = null;
    lastScanTime = null;

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.hasCameraPermission) return;

    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('AppLifecycleState.inactive');
        _resetSubscription();
        break;

      case AppLifecycleState.resumed:
        debugPrint('AppLifecycleState.resumed');
        _restartScanner();
        break;

      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _resetSubscription() {
    subscription?.cancel();
    subscription = null;
    unawaited(controller?.stop());
    debugPrint('🔄 Scanner reset and subscription cancelled');
  }

  void _restartScanner() {
    if (controller != null) {
      debugPrint('🔄 Restarting scanner');
      lastScanTime = DateTime.now();
      controller!.start();
      subscription = controller!.barcodes.listen(_onDetectBarcode);
    }
  }

  void _onDetectBarcode(BarcodeCapture barcodeCapture) async {
    // final barcode = findBarcodeAtCenter(
    //   barcodeCapture,
    //   DeviceOrientation.portraitUp,
    // );
    final barcode = barcodeCapture.barcodes.first.displayValue;

    if (barcode == null) return;

    final qrCode = barcode;
    final now = DateTime.now();

    final isDuplicate = lastScannedCode == qrCode;
    final isInCooldown =
        lastScanTime != null && now.difference(lastScanTime!) < scanCooldown;

    if (isDuplicate && isInCooldown) {
      debugPrint('⏱️ Duplicate QR within cooldown, ignoring: $qrCode');
      return;
    }

    // Update last scan
    lastScannedCode = qrCode;
    lastScanTime = now;

    // context.read<ScanQrProvider>().validateScanQr(
    //   context: context,
    //   qrCode: qrCode,
    //   onLoading: () {
    //     _resetSubscription();
    //     showLoadingDialog(context, message: 'Memverifikasi QR kode');
    //   },
    //   onError: (message) {
    //     _resetSubscription();
    //     showErrorDialogWithSingleAction(
    //       context,
    //       title: 'Gagal Memverifikasi QR',
    //       description: message,
    //       onPositivePressed: () {
    //         context.pop();
    //         _restartScanner();
    //       },
    //     );
    //   },
    //   onSuccess: (redirectUrl) async {
    _resetSubscription();
    // if (redirectUrl.isNotEmpty) {
    // final result = await context.pushNamed(
    //   Routes.savingPaymentBINA,
    // );
    // context.pushNamed(Routes.detailPelangganPage);
    context.pushNamed(
      Routes.detailPelangganPage,
      queryParameters: {
        // 'transactionNumber': data.transactionNumber ?? ''
        'transactionNumber': base64Encode(utf8.encode('Testing')),
      },
    );

    // if (result != null) {
    //   if (result is String && result == PaymentStatus.cancelled) {
    //     _resetSubscription();
    //     _restartScanner();
    //   }
    // }
    // }
    //   },
    // );
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
              top: 16.h,
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
                      Language.scanQr,
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

        // Content Bawah
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
                // Area Scanner Live
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 16.w),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (controller == null) {
                          return const LoadingWidget();
                        }

                        return Stack(
                          children: [
                            // Live Camera Preview
                            MobileScanner(
                              controller: controller,
                              onDetect: _onDetectBarcode,
                              errorBuilder: (context, exception) =>
                                  _onErrorWidget(context, exception),
                              onDetectError: _onDetectError,
                              placeholderBuilder: (_) => _onPlaceholder(),
                              fit: BoxFit.cover,
                            ),

                            // 🔴 Animasi Garis Scan Merah
                            AnimatedBuilder(
                              animation: _scanLineAnimation,
                              builder: (context, child) {
                                return Align(
                                  alignment: Alignment(
                                    0,
                                    _scanLineAnimation.value,
                                  ),
                                  child: Container(
                                    height: 2.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withValues(
                                        alpha: 0.9,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.redAccent.withValues(
                                            alpha: 0.6,
                                          ),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            // // Tombol Flash (fungsional)
                            Positioned(
                              bottom: 16.h,
                              right: 16.w,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    if (controller != null) {
                                      controller!.toggleTorch();
                                    }
                                  },
                                  splashColor: baseBlack.withValues(alpha: 0.5),
                                  child: Ink(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: baseWhite,
                                    ),
                                    child: Icon(
                                      controller?.torchEnabled == true
                                          ? Remix.flashlight_fill
                                          : Remix.flashlight_line,
                                      size: 24.w,
                                      color: text700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                verticalSpace(24.h),
                Center(
                  child: Text(
                    Language.arahkanKameraKeKodeQr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: text400,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: medium,
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

  Widget _onPlaceholder() {
    return const ShimmerWidget(width: double.infinity, height: double.infinity);
  }

  void _onDetectError(Object object, StackTrace stackTrace) {
    debugPrint('onDetectError-scanQR: $object');
    showCustomSnackBar(
      context,
      'Terjadi Kesalahan: $object',
      Color(0xFFB7242D),
    );
  }

  Widget _onErrorWidget(
    BuildContext context,
    MobileScannerException exception,
  ) {
    final messageDetails = exception.errorDetails?.message;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Feather.alert_triangle, size: 36.sp, color: error800),
        verticalSpace(12.h),
        Text(
          'Terjadi Kesalahan',
          style: blackTextStyle.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: text700,
            fontFamily: 'Inter',
          ),
        ),
        verticalSpace(8.h),
        Text(
          messageDetails ?? 'Silahkan coba beberapa saat lagi',
          style: blackTextStyle.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: text700,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
