// bottomsheet_edit_memo.dart
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class EditMemoBottomSheet extends StatefulWidget {
  const EditMemoBottomSheet({super.key});

  @override
  State<EditMemoBottomSheet> createState() => _EditMemoBottomSheetState();
}

class _EditMemoBottomSheetState extends State<EditMemoBottomSheet> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Memo',
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

          // Memo Input Field
          Container(
            width: double.infinity,
            height: 120.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: baseWhite,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: borderDark),
            ),
            child: TextField(
              controller: _memoController,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Masukan Memo',
                hintStyle: TextStyle(color: text400),
              ),
              style: TextStyle(fontSize: 14.sp, color: text500Base),
            ),
          ),
          verticalSpace(24.h),

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
                  // Handle simpan action
                  Navigator.pop(context, _memoController.text);
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
          verticalSpace(16.h),
        ],
      ),
    );
  }

  // Widget _buildDataItem(String label, String value) {
  //   return Container(
  //     padding: EdgeInsets.all(12.w),
  //     decoration: BoxDecoration(
  //       color: baseWhite,
  //       borderRadius: BorderRadius.circular(8.r),
  //       border: Border.all(color: borderDark),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 12.sp,
  //             fontWeight: FontWeight.w400,
  //             color: text400,
  //           ),
  //         ),
  //         verticalSpace(4.h),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             fontSize: 14.sp,
  //             fontWeight: FontWeight.w600,
  //             color: text500Base,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
