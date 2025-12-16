
// class LoginUseCase extends BaseUseCase<BaseResponse<LoginResponse>,
//     BaseRequest<LoginRequest>> {
//   final AuthRepository _authRepository;

//   LoginUseCase({
//     required AuthRepository authRepository,
//   }) : _authRepository = authRepository;

//   @override
//   Future<Either<Failure, BaseResponse<LoginResponse>>> call(
//       BaseRequest<LoginRequest> params) async {
//     return await _authRepository.login(params);
//   }
// }
