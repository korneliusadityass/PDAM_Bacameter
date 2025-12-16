
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../data_sources/remote/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource;

  // @override
  // Future<Either<Failure, BaseResponse<LoginResponse>>> login(
  //   BaseRequest<LoginRequest> loginRequest,
  // ) async {
  //   try {
  //     final response = await _authRemoteDataSource.login(loginRequest);
  //     if (response.statusCode == '00' || response.statusCode == '68') {
  //       return Right(response);
  //     } else {
  //       return Left(ServerFailure(response.message));
  //     }
  //   } on DioException catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     return Left(ServerFailure(errorMessage));
  //   }
  // }

}
