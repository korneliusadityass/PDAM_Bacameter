import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final void Function(int index) onTap;
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.095,
        decoration: const BoxDecoration(
          color: baseWhite,
          boxShadow: [
            BoxShadow(
              color: text300,
              offset: Offset(0, -1),
              blurRadius: 0,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map(
                (item) => GestureDetector(
                  onTap: () => onTap(item.index),
                  child: item,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final List<String> title;
  final IconData icon; // Ganti String menjadi IconData
  final IconData selectedIcon; // Ganti String menjadi IconData

  const BottomNavBarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Icon(
              isSelected ? selectedIcon : icon, // Gunakan Icon widget
              color: isSelected ? primary500Base : text300,
              size: 24.w,
            ),
          ),
          verticalSpace(3.h),
          Column(
            children: title
                .map((text) => Text(
                      text,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isSelected ? primary500Base : text300,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}