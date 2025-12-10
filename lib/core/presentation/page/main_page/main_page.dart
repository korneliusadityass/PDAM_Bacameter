import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/home/home_page.dart';
import 'package:baca_meter/core/presentation/page/management_data/management_data_page.dart';
import 'package:baca_meter/core/presentation/page/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ManagementDataPage(),
    ProfilePage(),
    // Tambahkan halaman lain jika perlu
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final extraSpace = 20.h; // 👈 tambahan ruang di bawah bottom bar

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Halaman utama
          SafeArea(
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

          // Layer putih di bagian bawah (termasuk extra space)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height:
                80.h + bottomPadding + extraSpace, // 👈 tambahkan extraSpace
            child: Container(color: baseWhite),
          ),

          // Bottom navigation bar (naikkan agar ada jarak di bawahnya)
          Positioned(
            bottom: bottomPadding + extraSpace, // 👈 turun sejauh extraSpace
            left: 0,
            right: 0,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: baseBlack.withValues(alpha: 0.11),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navBarItems.length, (index) {
          final item = _navBarItems[index];
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  size: 24,
                  color: isSelected ? primary500Base : text300,
                ),
                const SizedBox(height: 4),
                ...item.title.map(
                  (line) => Text(
                    line,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? primary500Base : text300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<NavBarItem> get _navBarItems => [
    NavBarItem(
      title: const ['Home'],
      icon: Remix.home_6_fill,
      selectedIcon: Remix.home_6_fill,
    ),
    NavBarItem(
      title: const ['Manajemen Data'],
      icon: Remix.folders_fill,
      selectedIcon: Remix.folders_fill,
    ),
    NavBarItem(
      title: const ['Profile'],
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
