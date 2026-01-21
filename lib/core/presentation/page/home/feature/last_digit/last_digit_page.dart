import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/routes/routes.dart';
import '../../../../commons/themes/text_styel.dart';
import '../../../../widget/custom_keyboard/custom_keyboard.dart';

class LastDigitPage extends StatefulWidget {
  const LastDigitPage({super.key});

  @override
  State<LastDigitPage> createState() => _LastDigitPageState();
}

class _LastDigitPageState extends State<LastDigitPage> {
  String _inputValue = '';
  bool _showKeyboard = false;
  Map<String, dynamic>? _searchResult;
  final List<Map<String, String>> _searchHistory = [];

  // Method untuk menambahkan riwayat pencarian
  void _addToSearchHistory(String lastDigits, String name, String fullNumber) {
    // Cek apakah sudah ada dalam riwayat dengan lastDigits yang sama
    bool alreadyExists = _searchHistory.any(
      (item) => item['lastDigits'] == lastDigits,
    );

    if (!alreadyExists) {
      setState(() {
        _searchHistory.insert(0, {
          'lastDigits': lastDigits,
          'name': name,
          'fullNumber': fullNumber,
        });

        // Batasi riwayat maksimal 10 item (opsional)
        if (_searchHistory.length > 10) {
          _searchHistory.removeLast();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackground(context),
          _buildContent(context),

          // Search Input dan Custom Keyboard Floating - dijadikan satu
          _searchLastDigit(),
        ],
      ),
    );
  }

  Widget _searchLastDigit() {
    return Positioned(
      bottom: 16.h,
      left: 16.w,
      right: 16.w,
      child: Column(
        children: [
          // Search Input
          _buildSearchInput(context),

          // Custom Keyboard (muncul saat _showKeyboard == true)
          if (_showKeyboard) ...[verticalSpace(22.h), _buildCustomKeyboard()],
        ],
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
            height: height * 0.2,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: primary500Base),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/icon/home/ic_appbar.png',
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

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 🔥 AREA BACKGROUND
        Expanded(
          flex: 2, // tinggi relatif (background)
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultMargin.w,
              top: 16.h,
              right: defaultMargin.w,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Remix.arrow_left_line,
                      color: baseWhite,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Language.lastDigit,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Inter',
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8, // tinggi relatif (background)
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white /* Color-Base-color-Background-Bg-white */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _inputValue.length == 3 ? 'Pencarian' : 'Riwayat Pencarian',
                    style: TextStyle(
                      color: text700,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: bold,
                    ),
                  ),
                  verticalSpace(16.h),

                  _inputValue.length == 3
                      ? _buildSearchResult()
                      : _buildSearchHistory(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchHistory() {
    if (_searchHistory.isEmpty) {
      return _buildEmpty();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchHistory.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: text300),
      itemBuilder: (context, index) {
        final item = _searchHistory[index];
        return GestureDetector(
          onTap: () {
            // Ketika item riwayat diklik, isi input dengan lastDigits
            setState(() {
              _inputValue = item['lastDigits']!;
              _searchResult = {
                'nomor': item['fullNumber'],
                'nama': item['name'],
                'lokasi':
                    'BONTOMANAI', // Anda bisa simpan lokasi juga jika perlu
              };
            });
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              item['name']!,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              '*******${item['lastDigits']!}',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResult() {
    final fullNumber = _searchResult?['nomor'] ?? '2039948885990';
    final name = _searchResult?['nama'] ?? 'Rey Ronald';
    final location = _searchResult?['lokasi'] ?? 'BONTOMANAI';

    // Pisahkan 3 digit terakhir
    final last3Digits = fullNumber.substring(fullNumber.length - 3);
    final prefix = fullNumber.substring(0, fullNumber.length - 3);

    return GestureDetector(
      onTap: () {
        // Simpan ke riwayat sebelum navigasi
        _addToSearchHistory(last3Digits, name, fullNumber);

        context.pushNamed(Routes.detailPelangganPage);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 120.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: baseWhite,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nomor Pelanggan dengan highlight 3 digit terakhir
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: prefix,
                    style: TextStyle(fontSize: 12.sp, color: text500Base),
                  ),
                  TextSpan(
                    text: last3Digits,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: secondary500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(8.h), // ⬅️ Tambah spacing
            Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: text500Base,
              ),
            ),
            verticalSpace(8.h), // ⬅️ Tambah spacing
            Row(
              children: [
                Icon(Remix.map_pin_fill, size: 16, color: baseBlack),
                horizontalSpace(4.w),
                Expanded(
                  // ⬅️ Agar text tidak overflow
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 14.sp, color: text600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showKeyboard = true;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: ShapeDecoration(
          color: Colors.white /* Color-Base-color-Background-Bg-white */,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderDefault),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x1E636363),
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Input Field (Text)
            Expanded(
              child: Text(
                _inputValue.isEmpty && !_showKeyboard
                    ? 'Masukan 3 Digit Terakhir No Pelanggan'
                    : _inputValue,
                style: TextStyle(
                  color: _inputValue.isEmpty && !_showKeyboard
                      ? text300
                      : text700,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: medium,
                ),
              ),
            ),

            horizontalSpace(13.w),

            // Icon Search
            GestureDetector(
              onTap: () {
                _doneSearch();
              },
              child: Icon(Remix.search_line, size: 24, color: baseBlack),
            ),
          ],
        ),
      ),
    );
  }

  void _setValueKeyboard(String value) {
    // logic tetap di page
    if (_inputValue.length < 3) {
      setState(() {
        _inputValue += value;
        // Reset hasil pencarian saat input berubah
        if (_inputValue.length < 3) {
          _searchResult = null;
        }
      });
    }

    // 🔥 Auto-search ketika sudah 3 digit
    if (_inputValue.length == 3) {
      final searchData = {
        'nomor': '2039948885$_inputValue',
        'nama': 'Rey Ronald',
        'lokasi': 'BONTOMANAI',
      };

      setState(() {
        _searchResult = searchData;
      });

      // Simpan ke riwayat pencarian
      _addToSearchHistory(
        _inputValue,
        searchData['nama']!,
        searchData['nomor']!,
      );
    }
  }

  Widget _buildCustomKeyboard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.h),
      color: baseWhite,
      child: Column(
        children: [
          // Baris 1
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Expanded(child: _buildNumberButton('1')),
              Expanded(
                child: CustomKeyboardButton(
                  label: '1',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),

              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '2',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '3',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
            ],
          ),
          verticalSpace(12.h),

          // Baris 2
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomKeyboardButton(
                  label: '4',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '5',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '6',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
            ],
          ),
          verticalSpace(12.h),

          // Baris 3
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomKeyboardButton(
                  label: '7',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '8',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '9',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
            ],
          ),
          verticalSpace(12.h),

          // Baris 4 (Clear, 0, Submit)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomKeyboardButton(
                  label: 'Clear',
                  backgroundColor: primary100,
                  textColor: primary500Base,
                  onTap: (value) {
                    setState(() {
                      _inputValue = '';
                      _searchResult = null;
                    });
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  label: '0',
                  borderColor: borderDark,
                  onTap: (value) {
                    _setValueKeyboard(value);
                  },
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: CustomKeyboardButton(
                  iconParam: Remix.arrow_right_s_line,
                  backgroundColor: primary500Base,
                  warnaIcons: baseWhite,
                  onTap: (value) {
                    _doneSearch();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _doneSearch() {
    if (_inputValue.length == 3) {
      // Simulasi pencarian — ganti dengan API/Database nanti
      final searchData = {
        'nomor': '2039948885$_inputValue',
        'nama': 'Rey Ronald',
        'lokasi': 'BONTOMANAI',
      };
      setState(() {
        _searchResult = searchData;
      });
      // Simpan ke riwayat pencarian
      _addToSearchHistory(
        _inputValue,
        searchData['nama']!,
        searchData['nomor']!,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Masukkan 3 digit')));
    }
    // Tutup keyboard setelah submit
    setState(() {
      _showKeyboard = false;
    });
  }

  Widget _buildEmpty() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(40.h),
            Image.asset(
              'assets/images/img_empty_fix.png',
              width: 220.w,
              height: 220.h,
              fit: BoxFit.contain,
            ),
            verticalSpace(16.h),
            Text(
              'Riwayat Pencarian Belum Tersedia',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: text600,
              ),
            ),
            verticalSpace(8.h),
          ],
        ),
      ),
    );
  }
}
