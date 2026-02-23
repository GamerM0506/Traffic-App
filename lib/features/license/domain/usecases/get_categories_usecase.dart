import 'package:dartz/dartz.dart';
import 'package:traffic_app/core/usecases/usecase.dart';
import 'package:traffic_app/features/license/domain/entities/license_entity.dart';
import 'package:traffic_app/features/license/domain/repositories/license_repository.dart';

import '../../../../core/error/failures.dart';

class GetCategoriesUseCase implements UseCase<List<LicenseCategoryEntity>, NoParams> {
  final LicenseRepository repository;
  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<LicenseCategoryEntity>>> call(
    NoParams params,
  ) async {
    return await repository.getLicenseTypes();
  }
}
