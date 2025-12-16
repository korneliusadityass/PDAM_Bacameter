import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../commons/routes/routes.dart';

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
      body: Stack(
        children: [
          // Background utama
          Column(
            children: [
              // Header dengan background biru
              _buildHeader(context),
              // Area putih di bawah header
              Expanded(child: Container(color: baseWhite)),
            ],
          ),

          // Konten utama yang menumpang di atas header
          Positioned(
            top: 140.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (_showKeyboard) {
                  setState(() {
                    _showKeyboard = false;
                  });
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: baseWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Riwayat Pencarian / Pencarian
                      Text(
                        _inputValue.length == 3
                            ? 'Pencarian'
                            : 'Riwayat Pencarian',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: text500Base,
                        ),
                      ),
                      verticalSpace(4.h),

                      _inputValue.length == 3
                          ? _buildSearchResult()
                          : Expanded(
                              // ⬅️ Hanya riwayat yang pakai Expanded
                              child: _buildSearchHistory(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Search Input dan Custom Keyboard Floating - dijadikan satu
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              children: [
                // Search Input
                _buildSearchInput(context),
                verticalSpace(10.h),

                // Custom Keyboard (muncul saat _showKeyboard == true)
                if (_showKeyboard) ...[
                  verticalSpace(10.h),
                  _buildCustomKeyboard(),
                ],
              ],
            ),
          ),

          // SafeArea di atas stack untuk menghindari notch
          const SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primary500Base,
        image: const DecorationImage(
          image: AssetImage('assets/icon/home/ic_appbar.png'),
          fit: BoxFit.contain,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          verticalSpace(60.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Remix.arrow_left_line, color: baseWhite, size: 20),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Last Digit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const DetailPelangganPage()),
        // );
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
        height: 48.h,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: baseWhite,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderDark),
          boxShadow: [
            BoxShadow(
              color: baseBlack.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Input Field (Text)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  _inputValue.isEmpty && !_showKeyboard
                      ? 'Masukan 3 Digit Terakhir No Pelanggan'
                      : _inputValue,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _inputValue.isEmpty && !_showKeyboard
                        ? text400
                        : text500Base,
                    fontWeight: _inputValue.isNotEmpty
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),

            // Icon Search
            Icon(Remix.search_line, size: 18, color: text400),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return Container(
      height: 230.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12.h),
      decoration: BoxDecoration(color: baseWhite),
      child: Column(
        children: [
          // Baris 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('1'),
              _buildNumberButton('2'),
              _buildNumberButton('3'),
            ],
          ),
          verticalSpace(10.h),

          // Baris 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('4'),
              _buildNumberButton('5'),
              _buildNumberButton('6'),
            ],
          ),
          verticalSpace(10.h),

          // Baris 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('7'),
              _buildNumberButton('8'),
              _buildNumberButton('9'),
            ],
          ),
          verticalSpace(10.h),

          // Baris 4 (Clear, 0, Submit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _inputValue = '';
                    _searchResult = null;
                  });
                },
                child: Container(
                  width: 80.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: primary100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primary500Base,
                      ),
                    ),
                  ),
                ),
              ),
              _buildNumberButton('0'),
              GestureDetector(
                onTap: () {
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

                    // Tutup keyboard setelah submit
                    setState(() {
                      _showKeyboard = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Masukkan 3 digit')),
                    );
                  }
                },
                child: Container(
                  width: 80.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: primary500Base,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(
                      Remix.arrow_right_s_line,
                      color: baseWhite,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () {
        if (_inputValue.length < 3) {
          setState(() {
            _inputValue += number;
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
      },
      child: Container(
        width: 80.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: baseSection,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderDark),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
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
