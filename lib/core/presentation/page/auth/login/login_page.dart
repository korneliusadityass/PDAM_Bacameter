import 'package:baca_meter/core/presentation/commons/extensions/context_extension.dart';
import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/auth/login/provider/login_notifier.dart';
import 'package:baca_meter/core/presentation/page/auth/login/setting/setting_login_page.dart';
import 'package:baca_meter/core/presentation/widget/form_field/form_field_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../commons/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State manajemen
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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header dengan logo login
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: context.height * 0.3,
              child: Center(
                child: Image.asset(
                  'assets/icon/ic_baca_meter.png',
                  width: 89.w,
                  height: 80.h,
                ),
              ),
            ),

            // Card putih untuk konten - Expanded untuk mengisi sisa space
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color:
                      Colors.white /* Color-Base-color-Background-Bg-white */,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Konten utama
                    Selector<LoginNotifier, bool>(
                      selector: (context, provider) => provider.showLoginForm,
                      builder: (context, showLoginForm, child) {
                        return Column(
                          children: [
                            Text(
                              showLoginForm
                                  ? Language.masuk
                                  : Language.selamatDatang,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: text700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            verticalSpace(8.h),
                            Text(
                              showLoginForm
                                  ? Language
                                        .gunakanAkunYangTelahdiberikanOlehPerusahaan
                                  : Language
                                        .silahkanPilihPDAMTempatAndaBerkerjaTerlebihDahulu,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: text400,
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            verticalSpace(24.h),

                            // Tampilkan SettingsDialog atau form login
                            if (!context.read<LoginNotifier>().showLoginForm)
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
                        );
                      },
                    ),

                    // Spacer untuk mendorong footer ke bawah
                    const Spacer(),

                    // Footer
                    Selector<LoginNotifier, bool>(
                      selector: (context, provider) => provider.showLoginForm,
                      builder: (context, showLoginForm, child) {
                        return SizedBox(
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // 🔹 CENTER: Powered by MKP (selalu di tengah)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    Language.poweredBy,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: text700,
                                      fontWeight: FontWeight.w600,
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

                              // 🔹 RIGHT: Icon setting (hanya saat showLoginForm = true)
                              if (showLoginForm)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => _showSettingsDialog(),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: ShapeDecoration(
                                        color: baseSection,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Remix.settings_3_line,
                                        color: primary500Base,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Selector<LoginNotifier, bool>(
      selector: (context, provider) => provider.showLoginForm,
      builder: (context, showLoginForm, child) {
        return GestureDetector(
          onTap: showLoginForm ? _login : _onContinuePressed,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: primary500Base /* Color-Brand-color-Primary-Primary-5 */,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                showLoginForm ? Language.masuk : Language.lanjutkan,
                style: TextStyle(
                  color: baseWhite,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
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
          context.read<LoginNotifier>().setShowLoginForm(true);
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
      hint: Language.masukkanUsername,
      prefixIcon: Icon(Remix.user_fill, color: baseBlack, size: 20.sp),
    ),
  );

  Widget _buildPassword() => SizedBox(
    child: FormFieldOutline(
      inputType: TextInputType.visiblePassword,
      controller: _passwordController,
      title: '',
      prefixIcon: Icon(Remix.lock_2_fill, color: baseBlack, size: 20.sp),
      hint: Language.masukkanKataSandi,
      obscureText: true,
    ),
  );

  void _onContinuePressed() {
    if (_selectedPdam == null) {
      _showDialog('Error', 'Harap pilih PDAM terlebih dahulu');
      return;
    }
    context.read<LoginNotifier>().setShowLoginForm(true);
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    debugPrint('Username: $username');
    debugPrint('Password: $password');

    if (username.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Harap isi username dan password');
    } else {
      context.goNamed(Routes.mainPage);
    }
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
              context.read<LoginNotifier>().setShowLoginForm(true);
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
