import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:baca_meter/core/presentation/page/home/home_page.dart';
import 'package:baca_meter/core/presentation/page/management_data/management_data_page.dart';
import 'package:baca_meter/core/presentation/page/profile/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import '../../commons/extensions/context_extension.dart';
import '../../commons/methods/methods.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), ManagementDataPage(), ProfilePage()];

  // === Animation ===
  late final AnimationController _navBarController;
  late final Animation<Offset> _navBarSlide;
  late final Animation<double> _navBarFade;

  @override
  void initState() {
    super.initState();

    // Bottom nav bar: slide up + fade in (500ms, delay 300ms)
    _navBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _navBarSlide = Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _navBarController,
            curve: Curves.easeOutCubic,
          ),
        );
    _navBarFade = CurvedAnimation(
      parent: _navBarController,
      curve: Curves.easeOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _navBarController.forward();
    });
  }

  @override
  void dispose() {
    _navBarController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.isPhone) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: primary500Base,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: primary500Base,
        resizeToAvoidBottomInset: false,
        body:
            // Halaman utama
            SafeArea(
              // top: false,
              bottom: false,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),

        bottomNavigationBar: SafeArea(
          bottom: defaultTargetPlatform == TargetPlatform.android
              ? true
              : false,
          child: Container(color: Colors.white, child: _buildBottomNavBar()),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x1E636363),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SlideTransition(
        position: _navBarSlide,
        child: FadeTransition(
          opacity: _navBarFade,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navBarItems.length, (index) {
              final item = _navBarItems[index];
              final isSelected = _selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _pageController.jumpToPage(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: isSelected ? 1.2 : 1.0,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              isSelected ? item.selectedIcon : item.icon,
                              key: ValueKey<bool>(isSelected),
                              size: 24,
                              color: isSelected ? primary500Base : text300,
                            ),
                          ),
                        ),
                        verticalSpace(5.h),
                        ...item.title.map(
                          (line) => AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: isSelected ? semiBold : medium,
                              fontFamily: 'Inter',
                              color: isSelected ? primary500Base : text300,
                            ),
                            child: Text(line, textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  List<NavBarItem> get _navBarItems => [
    NavBarItem(
      title: [Language.home],
      icon: Remix.home_6_fill,
      selectedIcon: Remix.home_6_fill,
    ),
    NavBarItem(
      title: [Language.manajemenData],
      icon: Remix.folders_fill,
      selectedIcon: Remix.folders_fill,
    ),
    NavBarItem(
      title: [Language.profile],
      icon: Remix.user_3_fill,
      selectedIcon: Remix.user_3_fill,
    ),
  ];
}

class NavBarItem {
  final List<String> title;
  final IconData icon;
  final IconData selectedIcon;

  NavBarItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}
