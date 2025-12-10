import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/login/setting/setting_login_page.dart';
import 'package:baca_meter/core/presentation/page/main_page/main_page.dart';
import 'package:baca_meter/core/presentation/widget/form_field/form_field_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State manajemen
  bool _showLoginForm = false; // true jika sudah pilih PDAM
  String? _selectedPdam;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Data PDAM
  final List<Map<String, String>> _pdamData = [
    {'isiList': 'PDAM A'},
    {'isiList': 'PDAM B'},
    {'isiList': 'PDAM C'},
    {'isiList': 'PDAM D'},
    {'isiList': 'PDAM E'},
    {'isiList': 'PDAM F'},
    {'isiList': 'PDAM G'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary500Base,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // Header dengan logo login
          Padding(
            padding: EdgeInsets.only(top: 80.h, bottom: 40.h),
            child: Image.asset(
              'assets/icon/ic_baca_meter.png',
              width: 145.w,
              height: 84.h,
            ),
          ),

          // Card putih untuk konten - Expanded untuk mengisi sisa space
          Expanded(
            child: Container(
              width: double.infinity,
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
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Konten utama
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.r,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          _showLoginForm ? 'Masuk' : 'Selamat Datang',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: text900,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(16.h),
                        Text(
                          _showLoginForm
                              ? 'Gunakan akun yang telah diberikan oleh perusahaan'
                              : 'Silahkan Pilih PDAM tempat anda berkerja terlebih dahulu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: text700,
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        verticalSpace(24.h),

                        // Tampilkan SettingsDialog atau form login
                        if (!_showLoginForm)
                          _buildSettingsDialogWidget()
                        else
                          Column(
                            children: [
                              _buildUsername(),
                              verticalSpace(16.h),
                              _buildPassword(),
                            ],
                          ),

                        verticalSpace(24.h),

                        // Tombol: "Lanjutkan" atau "Masuk"
                        _buildLoginButton(),
                      ],
                    ),
                  ),

                  // Spacer untuk mendorong footer ke bawah
                  const Spacer(),

                  // Footer
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: _showLoginForm
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Spacer untuk menyeimbangkan layout - HANYA TAMPIL JIKA ADA ICON SETTING
                        if (_showLoginForm) SizedBox(width: 40.w),

                        // Powered by MKP di center - SELALU TAMPIL
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Powered by',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: baseBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            verticalSpace(4.h),
                            Image.asset(
                              'assets/icon/login/ic_logo_primary_mkp.png',
                              width: 85.w,
                              height: 24.h,
                            ),
                          ],
                        ),

                        // Icon setting di sebelah kanan - HANYA TAMPIL SAAT _showLoginForm = true
                        if (_showLoginForm)
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: primary500Base.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: primary500Base.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              onPressed: _onSettingsPressed,
                              icon: Icon(
                                Remix.settings_3_line,
                                color: primary500Base,
                                size: 24.sp,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          )
                        else
                          const SizedBox(), // Empty ketika icon setting tidak tampil
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _showLoginForm ? _login : _onContinuePressed,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: primary500Base,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _showLoginForm ? 'Masuk' : 'Lanjutkan',
            style: TextStyle(
              color: baseWhite,
              fontSize: 16.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Widget yang memanggil SettingsDialog secara langsung
  Widget _buildSettingsDialogWidget() {
    return SettingsDialog(
      selectedPdam: _selectedPdam,
      onPdamChanged: (String? newValue) {
        setState(() {
          _selectedPdam = newValue;
        });
        debugPrint('PDAM selected: $newValue');
      },
      onSave: () {
        // Tidak perlu navigator pop karena ini bukan dialog
        _showDialog('Berhasil', 'Pengaturan PDAM telah disimpan');
      },
      onLogin: () {
        if (_selectedPdam != null) {
          setState(() {
            _showLoginForm = true;
          });
        } else {
          _showDialog('Error', 'Harap pilih PDAM terlebih dahulu');
        }
      },
      pdamData: _pdamData,
      isInline: true, // Tambahkan parameter ini
    );
  }

  Widget _buildUsername() => SizedBox(
    child: FormFieldOutline(
      inputType: TextInputType.text,
      controller: _usernameController,
      title: '',
      hint: 'Masukkan Username',
      prefixIcon: Icon(Remix.user_fill, color: baseBlack, size: 20.sp),
    ),
  );

  Widget _buildPassword() => SizedBox(
    child: FormFieldOutline(
      inputType: TextInputType.visiblePassword,
      controller: _passwordController,
      title: '',
      prefixIcon: Icon(Remix.lock_2_fill, color: baseBlack, size: 20.sp),
      hint: 'Masukkan Kata Sandi',
      obscureText: true,
    ),
  );

  void _onContinuePressed() {
    if (_selectedPdam == null) {
      _showDialog('Error', 'Harap pilih PDAM terlebih dahulu');
      return;
    }
    setState(() {
      _showLoginForm = true;
    });
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    debugPrint('Username: $username');
    debugPrint('Password: $password');

    if (username.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Harap isi username dan password');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  void _onSettingsPressed() {
    debugPrint('Settings button pressed');
    _showSettingsDialog();
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SettingsDialog(
          selectedPdam: _selectedPdam,
          onPdamChanged: (String? newValue) {
            setState(() {
              _selectedPdam = newValue;
            });
            debugPrint('PDAM selected: $newValue');
          },
          onSave: () {
            _showDialog('Berhasil', 'Pengaturan PDAM telah disimpan');
          },
          onLogin: () {
            if (_selectedPdam != null) {
              setState(() {
                _showLoginForm = true;
              });
            } else {
              _showDialog('Error', 'Harap pilih PDAM terlebih dahulu');
            }
          },
          pdamData: _pdamData,
        );
      },
    );
  }
}
