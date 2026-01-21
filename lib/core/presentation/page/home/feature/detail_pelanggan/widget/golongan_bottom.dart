// bottomsheet_pilih_golongan.dart
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class PilihGolonganBottomSheet extends StatefulWidget {
  const PilihGolonganBottomSheet({super.key});

  @override
  State<PilihGolonganBottomSheet> createState() =>
      _PilihGolonganBottomSheetState();
}

class _PilihGolonganBottomSheetState extends State<PilihGolonganBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGolongan = 'Gol A'; // Default selected
  
  final List<String> _golonganList = [
    'Gol A',
    'Gol B',
    'Gol C',
    'Gol D',
    'Gol E',
    'Gol F',
    'Gol G',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // Setengah layar
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: baseWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Golongan',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: text500Base,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Remix.close_fill, color: baseBlack, size: 24),
              ),
            ],
          ),
          verticalSpace(16.h),

          // Search Field
          Container(
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: baseWhite,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: borderDark),
            ),
            child: Row(
              children: [
                Icon(Remix.search_2_line, size: 20, color: text400),
                horizontalSpace(8.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari...',
                      hintStyle: TextStyle(color: text400),
                    ),
                    style: TextStyle(fontSize: 14.sp, color: text500Base),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(16.h),

          // Golongan List - Gunakan Expanded dengan flex yang tepat
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _golonganList.length,
              itemBuilder: (context, index) {
                final golongan = _golonganList[index];
                final isSelected = _selectedGolongan == golongan;

                return Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedGolongan = golongan;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? primary500Base
                                        : borderDark,
                                    width: 2.w,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primary500Base,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              horizontalSpace(12.w),
                              Text(
                                golongan,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: text500Base,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (index < _golonganList.length - 1)
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: borderDark.withValues(alpha: 0.3),
                      ),
                  ],
                );
              },
            ),
          ),

          verticalSpace(16.h),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: borderDark.withValues(alpha: 0.5),
          ),

          verticalSpace(16.h),

          // Simpan Button
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: primary500Base,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  Navigator.pop(context, _selectedGolongan);
                },
                child: Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: baseWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
