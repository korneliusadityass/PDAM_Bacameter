import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/widget/dropdown/form_dropdown.dart';
import 'package:baca_meter/core/presentation/widget/form_field/form_field_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class SettingsDialog extends StatefulWidget {
  final String? selectedPdam;
  final Function(String?)? onPdamChanged;
  final VoidCallback? onSave;
  final VoidCallback? onLogin;
  final List<Map<String, String>> pdamData;
  final bool isInline; // Parameter baru untuk menentukan mode

  const SettingsDialog({
    super.key,
    this.selectedPdam,
    this.onPdamChanged,
    this.onSave,
    this.onLogin,
    required this.pdamData,
    this.isInline = false, // Default false (sebagai bottom sheet)
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showPasswordField = false;
  String? _currentSelectedPdam;

  @override
  void initState() {
    super.initState();
    _currentSelectedPdam = widget.selectedPdam;
    _showPasswordField =
        _currentSelectedPdam != null && _currentSelectedPdam!.isNotEmpty;
  }

  @override
  void didUpdateWidget(SettingsDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedPdam != widget.selectedPdam) {
      setState(() {
        _currentSelectedPdam = widget.selectedPdam;
        _showPasswordField =
            widget.selectedPdam != null && widget.selectedPdam!.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jika mode inline, hanya tampilkan dropdown dan password
    if (widget.isInline) {
      return _buildContent();
    }

    // Jika mode bottom sheet, tampilkan dalam BottomSheet widget
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header hanya untuk bottom sheet
          _buildHeader(),
          verticalSpace(20),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: text900,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: baseWhite.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: baseWhite.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(Remix.close_fill, color: baseBlack, size: 26),
          ),
        ),
      ],
    );
  }

  // Widget _buildPassword() => FormFieldOutline(
  //   inputType: TextInputType.visiblePassword,
  //   controller: _passwordController,
  //   title: '',
  //   isWithTitle: false, // Ini yang penting - tidak render title
  //   prefixIcon: Icon(Remix.lock_2_fill, color: baseBlack, size: 20),
  //   hint: 'Masukkan password',
  //   obscureText: true,
  // );

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormDropdownButton(
          selectedValue: _currentSelectedPdam,
          onChanged: (value) {
            setState(() {
              _currentSelectedPdam = value;
              _showPasswordField = value != null && value.isNotEmpty;
            });
            widget.onPdamChanged?.call(value);
          },
          textHint: 'Pilih PDAM',
          data: widget.pdamData,
        ),

        if (_showPasswordField) ...[
          verticalSpace(16.h), // Jarak antara dropdown dan password
          _buildPassword(),
        ],

        if (!widget.isInline) ...[verticalSpace(20.h), _buildSaveButton()],
      ],
    );
  }

  Widget _buildPassword() => FormFieldOutline(
    inputType: TextInputType.visiblePassword,
    controller: _passwordController,
    title: '',
    prefixIcon: Icon(Remix.lock_2_fill, color: baseBlack, size: 20),
    hint: 'Masukkan password',
    obscureText: true,
  );

  Widget _buildSaveButton() => GestureDetector(
    onTap: () {
      widget.onSave?.call();
      Navigator.pop(context);
    },
    child: Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: primary500Base,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Simpan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
