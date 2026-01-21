import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import '../../commons/language/language.dart';
import '../../commons/methods/methods.dart';
import '../../commons/themes/color.dart';
import '../../commons/themes/text_styel.dart';

class PdamBottomSheetContent extends StatelessWidget {
  final StateSetter setModalState;
  final String judul;
  final String textTombol;
  final List<Map<String, String>> pdamData;
  final String? tempSelectedValue;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onClose;
  final VoidCallback onSubmit;
  final ValueChanged<String> onSelect;

  const PdamBottomSheetContent({
    super.key,
    required this.judul,
    required this.textTombol,
    required this.setModalState,
    required this.pdamData,
    required this.tempSelectedValue,
    required this.searchController,
    required this.searchFocusNode,
    required this.onClose,
    required this.onSubmit,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: neutralColor1,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              verticalSpace(16.h),
              _buildSearchField(),
              verticalSpace(16.h),
              _buildList(),
              verticalSpace(16.h),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: bold,
            color: text700,
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: const Icon(Remix.close_line, size: 24),
        ),
      ],
    );
  }

  // ================= SEARCH =================
  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white /* Color-Base-color-Background-Bg-white */,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderDefault),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextFormField(
        controller: searchController,
        focusNode: searchFocusNode,
        onTapOutside: (_) => searchFocusNode.unfocus(),
        onFieldSubmitted: (value) {},
        onChanged: (value) {
          setModalState(() {
            // _filteredPdamData = _pdamData.where((item) {
            //   final name = (item['isiList'] ?? '')
            //       .toString()
            //       .toLowerCase();
            //   return name.contains(value.toLowerCase());
            // }).toList();
          });
        },
        decoration: InputDecoration(
          isDense: true, // 🔹 penting
          contentPadding: EdgeInsets.zero, // 🔹 hapus padding bawaan
          border: InputBorder.none,

          // 🔍 Icon di dalam TextFormField
          prefixIcon: Icon(Remix.search_2_line, color: text500Base, size: 24),

          // // 🔹 hilangkan padding bawaan prefixIcon
          prefixIconConstraints: const BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          hintText: Language.cari,
          hintStyle: TextStyle(
            color: text300,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
      ),
    );
  }

  // ================= LIST =================
  Widget _buildList() {
    if (pdamData.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Tidak ada data PDAM',
            style: TextStyle(
              fontSize: 14.sp,
              color: text400,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: pdamData.length,
        itemBuilder: (context, index) {
          final value = pdamData[index]['isiList'] ?? '';
          final isSelected = tempSelectedValue == value;

          return GestureDetector(
            onTap: () => onSelect(value),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  _buildRadioCircle(isSelected),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: text700,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= RADIO =================
  Widget _buildRadioCircle(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? primary500Base : const Color(0xFFE6E6E6),
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary500Base,
                ),
              ),
            )
          : null,
    );
  }

  // ================= BUTTON =================
  Widget _buildSubmitButton() {
    final isEnabled = tempSelectedValue != null;

    return GestureDetector(
      onTap: isEnabled ? onSubmit : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isEnabled
              ? primary500Base
              : primary500Base.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          textTombol,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
