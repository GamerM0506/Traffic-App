import 'package:dartz/dartz.dart';
import 'package:traffic_app/core/error/failures.dart';
import 'package:traffic_app/features/license/domain/entities/license_entity.dart';

abstract class LicenseRepository {
  Future<Either<Failure, List<LicenseCategoryEntity>>> getLicenseTypes();
}
