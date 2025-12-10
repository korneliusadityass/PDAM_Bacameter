import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class FormDropdownButton extends StatefulWidget {
  final String? selectedValue;
  final Function(String? value)? onChanged;
  final String? judul;
  final String? statusForm;
  final String textHint;
  final List<Map<String, String>> data;

  const FormDropdownButton({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    this.judul,
    this.statusForm,
    required this.textHint,
    required this.data,
  });

  @override
  State<FormDropdownButton> createState() => _FormDropdownButtonState();
}

class _FormDropdownButtonState extends State<FormDropdownButton> {
  String? _tempSelectedValue;

  @override
  void initState() {
    super.initState();
    _tempSelectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.judul != null && widget.judul!.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.judul!,
                style: TextStyle(fontSize: 12.sp, fontWeight: semiBold),
              ),
              horizontalSpace(5.w),
              if (widget.statusForm != null && widget.statusForm!.isNotEmpty)
                Text(
                  widget.statusForm!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: regular,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ],
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderDefault, width: 1),
            ),
            child: Row(
              children: [
                Icon(Remix.contrast_drop_2_fill, color: baseBlack, size: 20),
                horizontalSpace(16.w),
                Expanded(
                  child: Text(
                    widget.selectedValue ?? widget.textHint,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.selectedValue != null
                          ? text500Base
                          : text400,
                    ),
                  ),
                ),
                Icon(Remix.arrow_down_s_line, color: baseBlack, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    _tempSelectedValue = widget.selectedValue;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return _buildBottomSheetContent(setModalState);
        },
      ),
    );
  }

  Widget _buildBottomSheetContent(StateSetter setModalState) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: baseWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih PDAM',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: text500Base,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Remix.close_line, size: 24),
                ),
              ],
            ),
            verticalSpace(20),

            // Search Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderDefault),
              ),
              child: Row(
                children: [
                  Icon(Remix.search_2_line, color: text400, size: 20),
                  horizontalSpace(8.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari...',
                        hintStyle: TextStyle(color: text400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(20),

            // List PDAM
            Expanded(
              child: widget.data.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data PDAM',
                        style: TextStyle(fontSize: 14.sp, color: text400),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        final item = widget.data[index];
                        final value = item['isiList'] ?? '';
                        final isSelected = _tempSelectedValue == value;

                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 8.w,
                          ), // Jarak antar item
                          child: GestureDetector(
                            onTap: () {
                              setModalState(() {
                                _tempSelectedValue = value;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.w,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primary500Base.withValues(
                                        alpha: 0.1,
                                      ) // Background ketika dipilih
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? primary500Base.withValues(alpha: 0.3)
                                      : text300,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Radio Button dengan Remix Icon
                                  Icon(
                                    isSelected
                                        ? Remix.radio_button_line
                                        : Remix.radio_button_line,
                                    size: 20.w,
                                    color: isSelected
                                        ? primary500Base
                                        : text400,
                                  ),
                                  horizontalSpace(12.w),

                                  // PDAM Name
                                  Expanded(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: text500Base,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            verticalSpace(20),

            // Tombol Pilih
            GestureDetector(
              onTap: () {
                if (_tempSelectedValue != null) {
                  widget.onChanged?.call(_tempSelectedValue);
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  color: _tempSelectedValue != null
                      ? primary500Base
                      : primary500Base.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Pilih',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
