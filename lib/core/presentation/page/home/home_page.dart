import 'package:baca_meter/core/presentation/commons/extensions/num_extension.dart';
import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/constants.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:remixicon/remixicon.dart';

import '../../../data/injection/injection.dart';
import '../../commons/extensions/context_extension.dart';
import '../../commons/routes/routes.dart';
import '../../manager/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final DatabaseHelper _dbHelper;
  int _totalPelanggan = 0;
  int _totalTerbaca = 0;
  int _totalBelumTerbaca = 0;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  // === Animation Controllers ===
  late final AnimationController _headerController;
  late final Animation<double> _profileFade;
  late final Animation<Offset> _profileSlide;

  late final AnimationController _badgeController;
  late final Animation<double> _badgeScale;
  late final Animation<double> _badgeFade;

  late final AnimationController _cardController;
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;

  late final AnimationController _buttonsController;
  late final Animation<double> _button1Scale;
  late final Animation<double> _button2Scale;
  late final Animation<double> _button3Scale;

  @override
  void initState() {
    super.initState();
    _dbHelper = sl<DatabaseHelper>();

    // 1. Profile header: fade + slide from left (600ms)
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _profileFade = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );
    _profileSlide = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );

    // 2. Periode badge: scale + fade (500ms, delay 200ms)
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _badgeScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _badgeController, curve: Curves.easeOutBack),
    );
    _badgeFade = CurvedAnimation(
      parent: _badgeController,
      curve: Curves.easeOut,
    );

    // 3. Stats card: slide up + fade (600ms, delay 400ms)
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _cardFade = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOut,
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );

    // 4. Action buttons: staggered scale (900ms total, delay 700ms)
    _buttonsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _button1Scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );
    _button2Scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _button3Scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Start animation sequence
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _badgeController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _cardController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _buttonsController.forward();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _loadStatistic();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _badgeController.dispose();
    _cardController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  Future<void> _loadStatistic() async {
    final result = await _dbHelper.getAllRayons();

    if (result.isLeft()) return;

    final rayons = result.getOrElse(() => []);

    int totalPelanggan = 0;
    int totalTerbaca = 0;
    int totalBelumTerbaca = 0;

    for (final r in rayons) {
      totalPelanggan += r.totalList;
      totalTerbaca += r.totalListTerbaca;
      totalBelumTerbaca += r.totalListBelumTerbaca;
    }

    if (!mounted) return;

    setState(() {
      _totalPelanggan = totalPelanggan;
      _totalTerbaca = totalTerbaca;
      _totalBelumTerbaca = totalBelumTerbaca;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [_buildBackground(context), _buildContent(context)],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return
    // LiquidPullToRefresh(
    //   backgroundColor: neutralColor1,
    //   color: primary300,
    //   springAnimationDurationInMilliseconds: 700,
    //   onRefresh: () async {
    //     await _loadStatistic();
    //   },
    //   key: _refreshIndicatorKey,
    //   showChildOpacityTransition: false,
    //   child:
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile
        SlideTransition(
          position: _profileSlide,
          child: FadeTransition(
            opacity: _profileFade,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin.w,
                vertical: 16.h,
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.person, color: Colors.blue[700], size: 35),
                  ),
                  horizontalSpace(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rey Ronald',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: semiBold,
                        ),
                      ),
                      verticalSpace(4.h),
                      Text(
                        'Petugas Pembaca Meter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Periode Pembacaan
        FadeTransition(
          opacity: _badgeFade,
          child: ScaleTransition(
            scale: _badgeScale,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: defaultMargin.w,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Periode Pembacaan: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: regular,
                            ),
                          ),
                          TextSpan(
                            text: 'Oktober 2025',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Content
        Expanded(child: _content()),
      ],
    )
    // )
    ;
  }

  Widget _content() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        // clipBehavior: Clip.hardEdge,
        width: double.infinity,
        color: Colors.white,
        // decoration: ShapeDecoration(
        //   color: Colors.white /* Color-Base-color-Background-Bg-white */,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(24),
        //       topRight: Radius.circular(24),
        //     ),
        //   ),
        // ),
        child: LiquidPullToRefresh(
          backgroundColor: neutralColor1,
          color: primary300,
          springAnimationDurationInMilliseconds: 700,
          onRefresh: () async {
            await _loadStatistic();
          },
          key: _refreshIndicatorKey,
          showChildOpacityTransition: false,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              verticalSpace(24.h),
              Padding(
                padding: EdgeInsets.only(
                  // top: 24.h,
                  left: 16.w,
                  right: 16.w,
                  // bottom: 16.h,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ), // EdgeInsets.all16),
                  decoration: ShapeDecoration(
                    color: const Color(
                      0xFFF0F3FF,
                    ) /* Color-Base-color-Background-Bg-sections */,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Language.laporanProduktivitasPembaca,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF1F1F25),
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                      verticalSpace(24.h),
                      Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.6, // 👈 POTONG TINGGI JADI SETENGAH
                        child: Stack(
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
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: text700,
                                      fontSize: 28.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    'Selesai',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: text400,
                                      fontSize: 12.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(24.h),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildStatItem(
                            'Jumlah Pelanggan',
                            _totalPelanggan.toCurrencyNoRp(),
                          ),
                          verticalSpace(12.h),
                          _buildStatItem(
                            'Sudah Terbaca',
                            _totalTerbaca.toCurrencyNoRp(),
                          ),
                          verticalSpace(12.h),
                          _buildStatItem(
                            'Belum Terbaca',
                            _totalBelumTerbaca.toCurrencyNoRp(),
                          ),
                          verticalSpace(12.h),
                          _buildStatItem('Belum Upload', '0'),
                          verticalSpace(12.h),
                          _buildStatItem('Kelainan', '0'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(24.h),
              // Daftar
              SlideTransition(
                position: _cardSlide,
                child: FadeTransition(
                  opacity: _cardFade,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScaleTransition(
                          scale: _button1Scale,
                          child: _buildRayonList(),
                        ),
                        ScaleTransition(
                          scale: _button2Scale,
                          child: _buildLastDigit(),
                        ),
                        ScaleTransition(
                          scale: _button3Scale,
                          child: _buildScan(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace(200.h),
            ],
          ),
        ),
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
            height: height * 0.3,
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

  Widget _buildStatItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: medium,
            fontFamily: 'Inter',
            color: text700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: medium,
            fontFamily: 'Inter',
            color: text700,
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
            context.pushNamed(Routes.daftarRayonPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Remix.database_2_fill, color: baseWhite, size: 32),
              ],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.daftarRayon,
          textAlign: TextAlign.center,
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

  Widget _buildLastDigit() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.lastDigitPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.seo_fill, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.lastDigit,
          textAlign: TextAlign.center,
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

  Widget _buildScan() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.scanPage);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(
                0xFF2B3499,
              ) /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Remix.qr_code_line, color: baseWhite, size: 32)],
            ),
          ),
        ),
        verticalSpace(12.h),
        Text(
          Language.scan,
          textAlign: TextAlign.center,
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

  @override
  bool get wantKeepAlive => true;
}
