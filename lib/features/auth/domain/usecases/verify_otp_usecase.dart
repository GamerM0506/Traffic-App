import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import 'auth_params.dart';

class VerifyOtpUseCase implements UseCase<bool, VerifyOtpParams> {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params);
  }
}
