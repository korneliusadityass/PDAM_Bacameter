import 'package:dio/dio.dart';


abstract class AuthRemoteDataSource {
  // Future<BaseResponse<LoginResponse>> login(
  //   BaseRequest<LoginRequest> loginRequest,
  // );

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  // @override
  // Future<BaseResponse<LoginResponse>> login(
  //   BaseRequest<LoginRequest> loginRequest,
  // ) async {
  //   try {
  //     final response = await _dio.post(
  //       '${AppConfig.instance.baseApiUrl}/worker/request',
  //       data: loginRequest.toJson(),
  //       options: Options(
  //         headers: {
  //           'X-ADDITIONALINFO': await SharedPrefsHelper.getDeviceInfo(),
  //         },
  //       ),
  //     );

  //     return BaseResponse<LoginResponse>.fromJson(
  //       response.data,
  //       LoginResponse.fromJson,
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

}
