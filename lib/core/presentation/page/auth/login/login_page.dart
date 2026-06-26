import 'package:baca_meter/core/presentation/commons/extensions/context_extension.dart';
import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:baca_meter/core/presentation/widget/form_field_outline/form_field_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../commons/routes/routes.dart';
import '../../../manager/shared_preferences_helper.dart';
import '../../../widget/bottom_sheet_pilih_data/bottom_sheet_pilih_data.dart';
import '../../../widget/dropdown/form_dropdown.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {
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

  bool? showLoginForm = false;

  // === Animation Controllers ===
  late final AnimationController _logoController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  late final AnimationController _cardController;
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;

  late final AnimationController _contentController;
  late final Animation<double> _titleFade;
  late final Animation<double> _subtitleFade;
  late final Animation<double> _formFade;
  late final Animation<double> _buttonFade;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();

    // 1. Logo: fade in + scale (800ms)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // 2. Card: slide up + fade (600ms, delay 300ms)
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _cardFade = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOut,
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );

    // 3. Content: staggered fade (total 1200ms, delay 600ms)
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _titleFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _subtitleFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
    );
    _formFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    _buttonFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    // 4. Pulse: subtle scale repeat on button (1500ms)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animation sequence
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _cardController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _contentController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _pulseController.repeat(reverse: true);
    });

    // Listen to form changes for button state
    _usernameLoginController.addListener(_onFormChanged);
    _passwordLoginController.addListener(_onFormChanged);
    _passwordPDAMController.addListener(_onFormChanged);

    // Load shared prefs data
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final result = await SharedPrefsHelper.isFormLogin();
      final selectedPDAM = await SharedPrefsHelper.getSelectedPdam();

      if (!mounted) return;
      setState(() {
        showLoginForm = result;
        _selectedPdam = selectedPDAM;
      });
    });
  }

  void _onFormChanged() {
    setState(() {});
  }

  /// Cek apakah form sudah terisi lengkap
  bool get _isFormValid {
    if (showLoginForm == true) {
      return _usernameLoginController.text.isNotEmpty &&
          _passwordLoginController.text.isNotEmpty;
    } else {
      // Halaman pilih PDAM: cek PDAM terpilih + password PDAM
      return _selectedPdam != null &&
          _passwordPDAMController.text.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _usernameLoginController.removeListener(_onFormChanged);
    _passwordLoginController.removeListener(_onFormChanged);
    _passwordPDAMController.removeListener(_onFormChanged);
    _logoController.dispose();
    _cardController.dispose();
    _contentController.dispose();
    _pulseController.dispose();
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
                      child: FadeTransition(
                        opacity: _logoFade,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: Image.asset(
                            'assets/icon/ic_baca_meter.webp',
                            width: 89.w,
                            height: 80.h,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Card putih untuk konten
                  SlideTransition(
                    position: _cardSlide,
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: Transform.translate(
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
                              Column(
                                children: [
                                  // Judul dengan staggered fade
                                  FadeTransition(
                                    opacity: _titleFade,
                                    child: Text(
                                      showLoginForm == true
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
                                  ),
                                  verticalSpace(8.h),
                                  // Subtitle dengan staggered fade
                                  FadeTransition(
                                    opacity: _subtitleFade,
                                    child: Text(
                                      showLoginForm == true
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
                                  ),
                                  verticalSpace(24.h),

                                  // Form fields dengan staggered fade
                                  FadeTransition(
                                    opacity: _formFade,
                                    child: showLoginForm == false
                                        ? _buildWidgetPilihPDAM()
                                        : Column(
                                            children: [
                                              _buildUsernameLogin(),
                                              verticalSpace(16.h),
                                              _buildPasswordLogin(),
                                            ],
                                          ),
                                  ),

                                  verticalSpace(24.h),

                                  // Tombol dengan staggered fade + pulse
                                  FadeTransition(
                                    opacity: _buttonFade,
                                    child: ScaleTransition(
                                      scale: _pulseScale,
                                      child: _buildLoginButton(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                'assets/icon/login/ic_logo_primary_mkp.webp',
                width: 85.w,
                height: 24.h,
              ),
            ],
          ),

          if (showLoginForm == true)
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
  }

  Widget _buildLoginButton() {
    final isValid = _isFormValid;
    final buttonColor = isValid ? primary500Base : Colors.grey.shade400;
    final textColor = isValid ? baseWhite : Colors.grey.shade600;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isValid
              ? () async {
                  if (showLoginForm == true) {
                    await _login();
                  } else {
                    await _onContinuePressed();
                  }
                }
              : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Center(
              child: Text(
                showLoginForm == true ? Language.masuk : Language.lanjutkan,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
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
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      // New
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return PdamBottomSheetContent(
            judul: Language.pilihPDAM,
            textTombol: Language.pilih,
            setModalState: setModalState,
            pdamData: _pdamData,
            tempSelectedValue: _tempSelectedValue,
            searchController: onSearchPDAMController,
            searchFocusNode: searchPDAMFocusNode,
            onSelect: (value) {
              setModalState(() => _tempSelectedValue = value);
            },
            onClose: () => context.pop(),
            onSubmit: () async {
              await SharedPrefsHelper.setSelectedPdam(
                _tempSelectedValue.toString(),
              );

              if (!context.mounted) return;

              setState(() {
                _selectedPdam = _tempSelectedValue;
              });

              if (redirectFrom == 'setting') {
                _passwordPDAMController.clear();
              }

              context.pop();
            },
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

  Future<void> _onContinuePressed() async {
    if (_selectedPdam == null) {
      _showDialog('Error', 'Harap pilih PDAM terlebih dahulu');
      return;
    }
    // context.read<LoginNotifier>().setShowLoginForm(true);
    await SharedPrefsHelper.setFormLogin(true);
    setState(() => showLoginForm = true);
  }

  Future<void> _login() async {
    final username = _usernameLoginController.text;
    final password = _passwordLoginController.text;

    if (username.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Harap isi username dan password');
      return;
    }

    await SharedPrefsHelper.setSignedIn(true);

    if (!mounted) return;

    context.goNamed(Routes.mainPage);
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
