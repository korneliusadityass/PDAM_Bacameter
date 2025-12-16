import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:remixicon/remixicon.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  late MobileScannerController _controller;
  bool _flashOn = false;

  // Animasi garis scan
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
      autoStart: true,
      formats: [BarcodeFormat.qrCode],
    );

    // Inisialisasi animasi garis scan
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scanLineAnimation =
        Tween<double>(begin: 0.2, end: 0.8).animate(
          CurvedAnimation(parent: _scanLineController, curve: Curves.linear),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _scanLineController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _scanLineController.forward();
          }
        });

    _scanLineController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scanLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background utama
          Column(
            children: [
              _buildHeader(context),
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: baseWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  verticalSpace(20.h),

                  // Area Scanner Live
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          // Live Camera Preview
                          MobileScanner(
                            controller: _controller,
                            onDetect: (capture) {
                              final barcodes = capture.barcodes;
                              if (barcodes.isNotEmpty) {
                                final String? code = barcodes.first.rawValue;
                                if (code != null) {
                                  debugPrint('QR Code: $code');
                                  // Opsional: hentikan scan
                                  // _controller.stop();
                                }
                              }
                            },
                            fit: BoxFit.cover,
                          ),

                          // 🔴 Animasi Garis Scan Merah
                          AnimatedBuilder(
                            animation: _scanLineAnimation,
                            builder: (context, child) {
                              return Positioned(
                                top:
                                    _scanLineAnimation.value *
                                    (MediaQuery.of(context).size.height - 200),
                                left: 0,
                                right: 0,
                                child: Container(height: 2, color: Colors.red),
                              );
                            },
                          ),

                          // Tombol Flash (fungsional)
                          Positioned(
                            bottom: 10,
                            right: 12.w,
                            child: GestureDetector(
                              onTap: () {
                                _controller.toggleTorch();
                                setState(() {
                                  _flashOn = _controller.torchEnabled;
                                });
                                                            },
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: baseWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _flashOn
                                      ? Remix.flashlight_fill
                                      : Remix.flashlight_line,
                                  color: baseBlack,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(20.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Text(
                      'Arahkan kamera ke Kode QR',
                      style: TextStyle(fontSize: 16.sp, color: text300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SafeArea(top: true, child: SizedBox()),
        ],
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
                    'Scan QR',
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
}
