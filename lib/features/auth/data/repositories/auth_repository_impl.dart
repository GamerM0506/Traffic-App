import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_params.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../data_sources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    try {
      final userModel = await remoteDataSource.register(params);
      return Right(userModel);
    } on DioException catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    } catch (e) {
      return Left(ServerFailure('Không thể kết nối đến máy chủ'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final userModel = await remoteDataSource.login(params);
      if (userModel.accessToken != null && userModel.refreshToken != null) {
        await localDataSource.saveTokens(
          access: userModel.accessToken!,
          refresh: userModel.refreshToken!,
        );
      }
      return Right(userModel);
    } on DioException catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    } catch (e) {
      return Left(ServerFailure('Lỗi đăng nhập hệ thống'));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(VerifyOtpParams params) async {
    try {
      final result = await remoteDataSource.verifyOtp(params);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_extractMessage(e)));
    } catch (e) {
      return Left(ServerFailure('Lỗi xác thực mã OTP'));
    }
  }

  String _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data != null && data['message'] != null) {
      final msg = data['message'];
      return (msg is List) ? msg[0].toString() : msg.toString();
    }
    return 'Đã có lỗi từ máy chủ';
  }

  @override
  Future<Either<Failure, String?>> getCachedToken() async {
    try {
      final token = await localDataSource.getAccessToken();
      return Right(token);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
