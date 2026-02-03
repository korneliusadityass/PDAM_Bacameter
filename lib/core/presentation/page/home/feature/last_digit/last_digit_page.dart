import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../data/database/daftar_rayon/app_database.dart';
import '../../../../../data/enum/database/database_status.dart';
import '../../../../../data/injection/injection.dart';
import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/language/language.dart';
import '../../../../commons/routes/routes.dart';
import '../../../../commons/themes/text_styel.dart';
import '../../../../manager/database_helper.dart';
import '../../../../widget/custom_keyboard/custom_keyboard.dart';

class LastDigitPage extends StatefulWidget {
  const LastDigitPage({super.key});

  @override
  State<LastDigitPage> createState() => _LastDigitPageState();
}

class _LastDigitPageState extends State<LastDigitPage> {
  String _inputValue = '';
  bool _showKeyboard = false;

  List<PelangganTableData> _searchResult = [];
  final List<PelangganTableData> _searchHistory = [];

  late final DatabaseHelper _dbHelper;
  String? _errorMessage;

  PageStatus? _status;

  void _onTapSearchResult(PelangganTableData pelanggan) {
    final exists = _searchHistory.any((e) => e.id == pelanggan.id);

    if (!exists) {
      _searchHistory.insert(0, pelanggan);

      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
    }

    setState(() {});
  }

  Future<void> _onSearch(String value) async {
    if (value.length != 3) return;

    setState(() {
      _status = PageStatus.loading;
      _errorMessage = null;
      _searchResult.clear();
    });

    final result = await _dbHelper.searchPelangganByLastIdDigit(value);

    result.fold(
      (failure) {
        setState(() {
          _status = PageStatus.error;
          _errorMessage = failure.message;
          _searchResult.clear();
        });
      },
      (list) {
        if (list.isEmpty) {
          setState(() {
            _status = PageStatus.empty;
            _searchResult.clear();
          });
        } else {
          setState(() {
            _status = PageStatus.loaded;
            _searchResult = list;
          });
        }
      },
    );
  }

  @override
  void initState() {
    _dbHelper = sl<DatabaseHelper>();
    super.initState();
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
          flex: 2,
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
          flex: 8,
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
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
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

                _buildContentBody(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentBody() {
    // 🔹 BELUM SEARCH (input belum 3 digit)
    if (_inputValue.length != 3) {
      if (_searchHistory.isNotEmpty) {
        return _buildSearchHistory();
      }
      return _buildEmpty();
    }

    // 🔹 SUDAH SEARCH → pakai PageStatus
    switch (_status) {
      case PageStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case PageStatus.error:
        return Center(
          child: Text(
            _errorMessage ?? 'Terjadi kesalahan',
            style: const TextStyle(color: Colors.red),
          ),
        );

      case PageStatus.loaded:
        return _buildSearchResult();

      case PageStatus.empty:
      default:
        return _buildEmpty();
    }
  }

  Widget _buildSearchHistory() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchHistory.length,
      separatorBuilder: (_, __) => Column(
        children: [
          verticalSpace(8.h),
          Divider(height: 0.5, color: borderDefault),
          verticalSpace(8.h),
        ],
      ),
      itemBuilder: (context, index) {
        final pelanggan = _searchHistory[index];
        final idStr = pelanggan.idPelanggan.toString();
        final last3 = idStr.length >= 3
            ? idStr.substring(idStr.length - 3)
            : idStr;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == _searchHistory.length - 1 ? 300.h : 0.h,
            top: index == 0 ? 16.h : 0.h,
          ),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            title: Text(
              pelanggan.nama,
              style: TextStyle(
                color: baseBlack,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: regular,
              ),
            ),
            trailing: Text(
              '*******$last3',
              style: TextStyle(
                color: baseBlack,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: regular,
              ),
            ),
            onTap: () {
              // setState(() {
              // _inputValue = last3;
              // _searchResult
              //   ..clear()
              //   ..add(pelanggan);
              // });
              context.pushNamed(
                Routes.detailPelangganPage,
                extra: pelanggan, // kirim object langsung
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResult() {
    // if (_searchResult.isEmpty) return const SizedBox();
    final pelanggan = _searchResult.first;
    final fullNumber = pelanggan.idPelanggan.toString();
    final name = pelanggan.nama;
    final location = pelanggan.alamat;

    // Aman dari RangeError
    final last3Digits = fullNumber.length > 3
        ? fullNumber.substring(fullNumber.length - 3)
        : fullNumber;
    final prefix = fullNumber.length > 3
        ? fullNumber.substring(0, fullNumber.length - 3)
        : '';

    return Column(
      children: [
        verticalSpace(16.h),
        GestureDetector(
          onTap: () {
            _onTapSearchResult(pelanggan);
            context.pushNamed(
              Routes.detailPelangganPage,
              extra: pelanggan, // kirim object
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: borderDefault),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: prefix,
                        style: TextStyle(
                          color: text700,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
                          height: 1.43,
                        ),
                      ),
                      TextSpan(
                        text: last3Digits,
                        style: TextStyle(
                          color: secondary500,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(8.h),
                Text(
                  name,
                  style: TextStyle(
                    color: text700,
                    fontSize: 16.sp,
                    fontWeight: bold,
                    fontFamily: 'Inter',
                  ),
                ),
                verticalSpace(8.h),
                Row(
                  children: [
                    Icon(Remix.map_pin_fill, size: 16, color: text500Base),
                    horizontalSpace(8.w),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: text700,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: regular,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
        // // Reset hasil pencarian saat input berubah
        // if (_inputValue.length < 3) {
        //   _searchResult = null;
        // }
      });
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
                      // _searchResult = null;
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
    // if (_inputValue.length == 3) {
    //   _onSearch(_inputValue);
    // } else {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text('Masukkan 3 digit')));
    // }
    if (_inputValue.length == 3) {
      _onSearch(_inputValue);
    } else {
      setState(() {
        _status = PageStatus.empty;
      });

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
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(8.h),
          ],
        ),
      ),
    );
  }
}
