import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:traffic_app/features/license/data/datasources/license_remote_data_source.dart';
import 'package:traffic_app/features/license/domain/repositories/license_repository.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/license_entity.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  final LicenseRemoteDataSource remoteDataSource;

  LicenseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LicenseCategoryEntity>>> getLicenseTypes() async {
    try {
      final remoteLicense = await remoteDataSource.getLicenseTypes();
      return Right(remoteLicense);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối máy chủ'));
    } catch (e) {
      return Left(ServerFailure('Đã xảy ra lỗi không mong muốn'));
    }
  }
}
