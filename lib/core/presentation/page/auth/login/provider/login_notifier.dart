import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/utilities/state/request_state.dart';

enum SwitchFormState { phoneNumber, email }

class LoginNotifier extends ChangeNotifier {
  // final LoginUseCase _loginUseCase;
  // final LoginGoogleUseCase _loginGoogleUseCase;
  // final LoginFacebookUseCase _loginFacebookUseCase;
  // final LoginAppleUseCase _loginAppleUseCase;

  // LoginNotifier(
  //   this._loginUseCase,
  //   this._loginGoogleUseCase,
  //   this._loginFacebookUseCase,
  //   this._loginAppleUseCase,
  // );

  bool _showLoginForm = false; // true jika sudah pilih PDAM

  bool get showLoginForm => _showLoginForm;

  void setShowLoginForm(bool value) {
    _showLoginForm = value;
    notifyListeners();
  }

  void resetFormLogin() {
    _showLoginForm = false;
    notifyListeners();
  }


  final _switchFormState = SwitchFormState.phoneNumber;

  SwitchFormState get switchFormState => _switchFormState;

  final _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  final _email = '';

  String get email => _email;

  final _isAgreeWithTerms = false;

  bool get isAgreeWithTerms => _isAgreeWithTerms;

  final _loginState = RequestState.empty;

  RequestState get loginState => _loginState;

  // var _loginResponse = const BaseResponse<LoginResponse>();

  // BaseResponse<LoginResponse> get loginResponse => _loginResponse;

  // var _message = '';

  // String get message => _message;

  // Future switchForm(SwitchFormState state) async {
  //   _switchFormState = state;
  //   notifyListeners();
  // }

  // void setPhoneNumber(String phoneNumber) {
  //   _phoneNumber = phoneNumber;
  //   notifyListeners();
  // }

  // void setEmail(String email) {
  //   _email = email;
  //   notifyListeners();
  // }

  // void setAgreeWithTerms(bool value) {
  //   _isAgreeWithTerms = value;
  //   notifyListeners();
  // }

  // Future<void> login(BuildContext context, String state,
  //     {String? socialMail}) async {
  //   _loginState = RequestState.loading;
  //   notifyListeners();

  //   late String loginType;
  //   switch (state) {
  //     case 'phoneNumber':
  //       loginType = LoginType.phone.name;
  //     case 'email':
  //       loginType = LoginType.email.name;
  //     case 'google':
  //       loginType = LoginType.google.name;
  //     case 'facebook':
  //       loginType = LoginType.facebook.name;
  //     case 'apple':
  //       loginType = LoginType.apple.name;
  //     default:
  //       loginType = LoginType.phone.name;
  //   }

  //   final loginRequest = LoginRequest(
  //     loginType: loginType,
  //     phone: loginType == LoginType.phone.name ? '0$_phoneNumber' : '',
  //     email: loginType == LoginType.email.name ? _email : socialMail ?? '',
  //     deviceSN: await DeviceHelper.getDeviceId(),
  //     deviceType: DeviceHelper.isMpos ? 'mpos' : 'mobile',
  //   );

  //   debugPrint('Login Request: $loginRequest');

  //   final baseRequest = BaseRequest(
  //     apiCode: 'LOGIN_B2C_API',
  //     apiVersion: 1,
  //     request: loginRequest,
  //   );

  //   final result = await _loginUseCase.call(baseRequest);

  //   result.fold(
  //     (failure) {
  //       _loginState = RequestState.error;
  //       _message = failure.message;

  //       // Response static error message when account not registered
  //       const generalAccountNotRegistered = 'AKUN TIDAK TERDAFTAR';
  //       const facebookAccountNotRegistered =
  //           'Akun Facebook Anda Belum Ditambahkan!';
  //       const appleAccountNotRegistered = 'Akun Apple Anda Belum Ditambahkan!';
  //       const googleAccountNotRegistered =
  //           'Akun Google Anda Belum Ditambahkan!';

  //       final isAccountNotRegistered =
  //           failure.message.contains(generalAccountNotRegistered) ||
  //               failure.message.contains(facebookAccountNotRegistered) ||
  //               failure.message.contains(appleAccountNotRegistered) ||
  //               failure.message.contains(googleAccountNotRegistered);

  //       // Check if response message is 'account not registered'
  //       if (isAccountNotRegistered) {
  //         _errorAccountNotRegistered(context, loginType, socialMail);
  //         notifyListeners();
  //       } else {
  //         showErrorDialogWithSingleAction(
  //           context,
  //           title: failure.message,
  //           onPositivePressed: () => context.pop(),
  //         );
  //         notifyListeners();
  //       }
  //     },
  //     (response) async {
  //       _loginState = RequestState.loaded;
  //       _loginResponse = response;

  //       if (context.mounted) {
  //         await SharedPrefsHelper.setUserToken(response.result!.token);

  //         if (loginType == LoginType.google.name ||
  //             loginType == LoginType.facebook.name) {
  //           const bool isSignInOtp = true;
  //           if (isSignInOtp) {
  //             await SharedPrefsHelper.setIsSignInOtp(isSignInOtp);
  //             await SharedPrefsHelper.setUserToken(response.result!.token);
  //             if (response.result!.username.isNotEmpty) {
  //               await SharedPrefsHelper.setUsername(response.result!.username);
  //             }

  //             if (context.mounted) context.goNamed(Routes.main);
  //           }
  //         } else {
  //           if (context.mounted) {
  //             _redirectToOtpWithArguments(context, loginType);
  //           }
  //         }
  //       }
  //       notifyListeners();
  //     },
  //   );
  // }

  // Future<void> loginWithGoogle(BuildContext context) async {
  //   _loginState = RequestState.loading;
  //   notifyListeners();

  //   final result = await _loginGoogleUseCase.call(null);
  //   result.fold(
  //     (failure) {
  //       _loginState = RequestState.error;
  //       _message = failure.message;
  //       notifyListeners();

  //       // Google flow cancelled by user
  //       if (failure is UserCancelledException) {
  //         return;
  //       } else {
  //         showErrorDialogWithSingleAction(
  //           context,
  //           title: failure.message,
  //           onPositivePressed: () => context.pop(),
  //         );
  //       }
  //       notifyListeners();
  //     },
  //     (user) {
  //       // After flow login with google success, call login to verify user
  //       _loginState = RequestState.loaded;
  //       login(context, LoginType.google.name, socialMail: user.email);
  //       notifyListeners();
  //     },
  //   );
  // }

  // Future<void> loginWithFacebook(BuildContext context) async {
  //   _loginState = RequestState.loading;
  //   notifyListeners();

  //   final result = await _loginFacebookUseCase.call(null);
  //   result.fold(
  //     (failure) {
  //       _loginState = RequestState.error;
  //       _message = failure.message;
  //       notifyListeners();

  //       if (failure is UserCancelledException) {
  //         return;
  //       } else {
  //         showErrorDialogWithSingleAction(
  //           context,
  //           title: failure.message,
  //           onPositivePressed: () => context.pop(),
  //         );
  //       }
  //       notifyListeners();
  //     },
  //     (user) {
  //       _loginState = RequestState.loaded;
  //       login(context, LoginType.facebook.name, socialMail: user.email);
  //       notifyListeners();
  //     },
  //   );
  // }

  // Future<void> loginWithApple(BuildContext context) async {
  //   _loginState = RequestState.loading;
  //   notifyListeners();

  //   final result = await _loginAppleUseCase.call(null);
  //   result.fold(
  //     (failure) {
  //       _loginState = RequestState.error;
  //       _message = failure.message;
  //       notifyListeners();

  //       if (failure is UserCancelledException) {
  //         return;
  //       } else {
  //         showErrorDialogWithSingleAction(
  //           context,
  //           title: failure.message,
  //           onPositivePressed: () => context.pop(),
  //         );
  //       }
  //       notifyListeners();
  //     },
  //     (user) {
  //       _loginState = RequestState.loaded;
  //       login(context, LoginType.apple.name, socialMail: user.email);
  //       notifyListeners();
  //     },
  //   );
  // }

  // void _errorAccountNotRegistered(
  //     BuildContext context, loginType, String? socialMail) {
  //   showDialogWithDoubleAction(
  //     context,
  //     title: Language.textErrorPhoneNumberOrEmailIsNotRegisteredTitle,
  //     description:
  //         Language.textErrorPhoneNumberOrEmailIsNotRegisteredDescription,
  //     positiveButton: Language.textRegisterNewAccount,
  //     onPositivePressed: () {
  //       // Redirect to register with arguments
  //       context.pop();
  //       context.pushNamed(
  //         Routes.register,
  //         extra: RegisterArguments(
  //           loginType: loginType,
  //           arguments: loginType == LoginType.phone.name
  //               ? _phoneNumber
  //               : loginType == LoginType.email.name
  //                   ? _email
  //                   : socialMail!,
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _redirectToOtpWithArguments(
  //   BuildContext context,
  //   String loginType,
  // ) {
  //   context.pushNamed(
  //     Routes.otp,
  //     extra: OtpArguments(
  //       redirectFrom: Routes.login,
  //       arguments: loginType == LoginType.phone.name
  //           ? _phoneNumber
  //           : loginType == LoginType.email.name
  //               ? _email
  //               : '',
  //       otpReferenceDocNo: _loginResponse.result!.otpReferenceDocNo,
  //       uIdsPreGeneral: _loginResponse.result!.uIdsPreGeneral,
  //       loginType: _loginResponse.result!.loginType,
  //       loginStatusCode: _loginResponse.statusCode,
  //       countdownOtp: _loginResponse.result!.otpCountdownPhone,
  //     ),
  //   );
  // }

  // void resetState() {
  //   _message = '';
  //   _loginResponse = const BaseResponse<LoginResponse>();
  //   _phoneNumber = '';
  //   _email = '';
  //   _isAgreeWithTerms = false;
  //   _switchFormState = SwitchFormState.phoneNumber;
  //   _loginState = RequestState.empty;
  //   notifyListeners();
  // }

}
