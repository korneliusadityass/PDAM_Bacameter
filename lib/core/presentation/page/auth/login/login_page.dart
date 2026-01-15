import 'package:baca_meter/core/presentation/commons/extensions/context_extension.dart';
import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:baca_meter/core/presentation/page/auth/login/provider/login_notifier.dart';
import 'package:baca_meter/core/presentation/widget/form_field_outline/form_field_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../commons/routes/routes.dart';
import '../../../widget/dropdown/form_dropdown.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State manajemen
  String? _selectedPdam;

  String? _tempSelectedValue; // ✅ pindahkan ke page
  final TextEditingController _usernameLoginController =
      TextEditingController();
  final FocusNode _focusNodeUsernameLogin = FocusNode();
  final TextEditingController _passwordPDAMController = TextEditingController();
  final FocusNode _focusNodePasswordPDAM = FocusNode();
  final TextEditingController _passwordLoginController =
      TextEditingController();
  final FocusNode _focusNodePasswordLogin = FocusNode();

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
  void dispose() {
    _usernameLoginController.dispose();
    _passwordPDAMController.dispose();
    _passwordLoginController.dispose();
    _focusNodePasswordPDAM.dispose();
    _focusNodePasswordLogin.dispose();
    _focusNodeUsernameLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // LAYER 1: Content
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Header dengan logo login
                  Container(
                    color: primary500Base,
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    height: context.height * 0.33,
                    child: Center(
                      child: Image.asset(
                        'assets/icon/ic_baca_meter.png',
                        width: 89.w,
                        height: 80.h,
                      ),
                    ),
                  ),

                  // Card putih untuk konten
                  Transform.translate(
                    offset: const Offset(0, -24),
                    child: Container(
                      // height: context.height * 0.7,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors
                            .white /* Color-Base-color-Background-Bg-white */,
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
                            selector: (context, provider) =>
                                provider.showLoginForm,
                            builder: (context, showLoginForm, child) {
                              return Column(
                                children: [
                                  Text(
                                    showLoginForm
                                        ? Language.masuk
                                        : Language.selamatDatang,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
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
                                      fontFamily: 'Inter',
                                      fontSize: 14.sp,
                                      color: text400,
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  verticalSpace(24.h),

                                  // Tampilkan SettingsDialog atau form login
                                  if (!context
                                      .read<LoginNotifier>()
                                      .showLoginForm)
                                    // _buildSettingsDialogWidget()
                                    _buildWidgetPilihPDAM()
                                  else
                                    Column(
                                      children: [
                                        _buildUsernameLogin(),
                                        verticalSpace(16.h),
                                        _buildPasswordLogin(),
                                      ],
                                    ),

                                  verticalSpace(24.h),

                                  // Tombol: "Lanjutkan" atau "Masuk"
                                  _buildLoginButton(),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(200.h),
                ],
              ),
            ),

            // LAYER 2: FOOTER
            Positioned(left: 0, right: 0, bottom: 16, child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Selector<LoginNotifier, bool>(
      selector: (context, provider) => provider.showLoginForm,
      builder: (context, showLoginForm, child) {
        return SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Language.poweredBy,
                    style: TextStyle(
                      fontFamily: 'Inter',
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

              if (showLoginForm)
                Positioned(
                  right: 16,
                  child: GestureDetector(
                    onTap: _bottomSheetPengaturanPDAM,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: baseSection,
                        borderRadius: BorderRadius.circular(8),
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

  // Widget pilih PDAM
  Widget _buildWidgetPilihPDAM() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormDropdownButton(
          selectedValue: _selectedPdam,
          onChanged: (value) {
            // setState(() {
            //   _selectedPdam = value;
            // });
          },
          textHint: 'Pilih PDAM',
          data: _pdamData,
          onTap: () => _showPdamBottomSheet('view'),
        ),
        if (_selectedPdam != null) ...[
          verticalSpace(16.h),
          _buildPasswordPDAM(),
        ],
      ],
    );
  }

  void _showPdamBottomSheet(String redirectFrom) {
    debugPrint('showPdamBottomSheet');
    _tempSelectedValue = _selectedPdam; // ✅ sync awal

    final TextEditingController onSearchPDAMController =
        TextEditingController();
    final FocusNode searchPDAMFocusNode = FocusNode();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Language.pilihPDAM,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.sp,
                          fontWeight: bold,
                          color: text700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Remix.close_line, size: 24),
                      ),
                    ],
                  ),
                  verticalSpace(16.h),

                  // Search Field
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors
                          .white /* Color-Base-color-Background-Bg-white */,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: borderDefault),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: TextFormField(
                      controller: onSearchPDAMController,
                      focusNode: searchPDAMFocusNode,
                      onTapOutside: (_) => searchPDAMFocusNode.unfocus(),
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
                        contentPadding:
                            EdgeInsets.zero, // 🔹 hapus padding bawaan
                        border: InputBorder.none,

                        // 🔍 Icon di dalam TextFormField
                        prefixIcon: Icon(
                          Remix.search_2_line,
                          color: text500Base,
                          size: 24,
                        ),

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
                  ),
                  verticalSpace(16.h),

                  // List PDAM
                  Expanded(
                    child: _pdamData.isEmpty
                        ? Center(
                            child: Text(
                              'Tidak ada data PDAM',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: text400,
                                fontFamily: 'Inter',
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _pdamData.length,
                            itemBuilder: (context, index) {
                              final item = _pdamData[index];
                              final value = item['isiList'] ?? '';
                              final isSelected = _tempSelectedValue == value;

                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    _tempSelectedValue = value;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: ShapeDecoration(
                                    color: Colors
                                        .white /* Color-Base-color-Background-Bg-white */,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 16,
                                    children: [
                                      if (isSelected) ...[
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: primary500Base,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(68),
                                            ),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: ShapeDecoration(
                                                color: primary500Base,
                                                shape: const OvalBorder(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Container(
                                          width: 24,
                                          height: 24,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Colors
                                                .white /* Color-Base-color-Background-Bg-white */,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFE6E6E6),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(68),
                                            ),
                                          ),
                                        ),
                                      ],

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
                  ),
                  verticalSpace(16.h),

                  // Tombol Pilih
                  GestureDetector(
                    onTap: () {
                      if (_tempSelectedValue != null) {
                        setState(() {
                          _selectedPdam = _tempSelectedValue;
                        });
                        if (redirectFrom == 'setting') {
                          _passwordPDAMController.clear();
                        }
                        context.pop();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: _tempSelectedValue != null
                            ? primary500Base
                            : primary500Base.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        Language.pilih,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordPDAM() {
    return FormFieldOutline(
      inputType: TextInputType.visiblePassword,
      controller: _passwordPDAMController,
      prefixIcon: Icon(Remix.lock_2_fill, color: baseBlack, size: 20),
      hint: Language.masukkanPassword,
      obscureText: true,
      focusNode: _focusNodePasswordPDAM,
    );
  }

  Widget _buildUsernameLogin() => SizedBox(
    child: FormFieldOutline(
      inputType: TextInputType.text,
      controller: _usernameLoginController,
      focusNode: _focusNodeUsernameLogin,
      hint: Language.masukkanUsername,
      prefixIcon: Icon(Remix.user_fill, color: baseBlack, size: 20.sp),
    ),
  );

  Widget _buildPasswordLogin() => SizedBox(
    child: FormFieldOutline(
      inputType: TextInputType.visiblePassword,
      controller: _passwordLoginController,
      focusNode: _focusNodePasswordLogin,
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
    String username = _usernameLoginController.text;
    String password = _passwordLoginController.text;

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

  void _bottomSheetPengaturanPDAM() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header hanya untuk bottom sheet
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Language.pengaturan,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: text700,
                        ),
                      ),

                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Remix.close_line, size: 24),
                      ),
                    ],
                  ),
                  verticalSpace(16.h),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormDropdownButton(
                        selectedValue: _selectedPdam,
                        onChanged: (value) {
                          // debugPrint('Selected PDAM: $value');
                          // setState(() {
                          //   _selectedPdam = value;
                          // });
                        },
                        textHint: 'Pilih PDAM',
                        data: _pdamData,
                        onTap: () => _showPdamBottomSheet('setting'),
                      ),
                      if (_selectedPdam != null) ...[
                        verticalSpace(16.h),
                        _buildPasswordPDAM(),

                        verticalSpace(16.h),
                        // TOMBOL PILIH
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color:
                                  primary500Base /* Color-Brand-color-Primary-Primary-5 */,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              Language.simpan,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors
                                    .white /* Color-Base-color-Text-Text-1 */,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
