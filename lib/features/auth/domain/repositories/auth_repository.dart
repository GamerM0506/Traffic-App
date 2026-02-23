import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/auth_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, UserEntity>> register(RegisterParams params);
  Future<Either<Failure, bool>> verifyOtp(VerifyOtpParams params);
  Future<Either<Failure, String?>> getCachedToken();
}
