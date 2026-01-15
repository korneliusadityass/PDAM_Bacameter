// bottomsheet_edit_memo.dart
import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../commons/themes/text_styel.dart';

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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: ShapeDecoration(
            color: Colors.white /* Color-Base-color-Background-Bg-white */,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
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
                      color: text700,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: bold,
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
                height: 126,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color:
                      Colors.white /* Color-Base-color-Background-Bg-white */,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: borderDefault),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: _memoController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukan Memo',
                    hintStyle: TextStyle(
                      color: text300,
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: medium,
                    ),
                  ),
                  style: TextStyle(
                    color: text500Base,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: medium,
                  ),
                ),
              ),
              verticalSpace(16.h),

              // Simpan Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: primary500Base,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
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
                        Language.simpan,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              Colors.white /* Color-Base-color-Text-Text-1 */,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
