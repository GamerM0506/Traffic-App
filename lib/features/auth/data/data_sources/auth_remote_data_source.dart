import 'package:dio/dio.dart';
import 'package:traffic_app/features/auth/data/models/user_model.dart';
import 'package:traffic_app/features/auth/domain/usecases/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(RegisterParams params);
  Future<UserModel> login(LoginParams params);
  Future<bool> verifyOtp(VerifyOtpParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'fullName': params.name,
          'email': params.email,
          'password': params.password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': params.email, 'password': params.password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp(VerifyOtpParams params) async {
    try {
      final response = await dio.post(
        '/auth/verify',
        data: {'email': params.email, 'code': params.code},
      );
      return response.data == true;
    } catch (e) {
      rethrow;
    }
  }
}
