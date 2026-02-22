import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/traffic_sign_category_entity.dart';
import '../../domain/entities/traffic_sign_entity.dart';
import '../../domain/repositories/traffic_sign_repository.dart';
import '../datasources/traffic_sign_remote_data_source.dart';

class TrafficSignRepositoryImpl implements TrafficSignRepository {
  final TrafficSignRemoteDataSource remoteDataSource;

  TrafficSignRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TrafficSignCategoryEntity>>>
  getTrafficSignCategories() async {
    try {
      final remoteCategories = await remoteDataSource
          .getTrafficSignCategories();
      return Right(remoteCategories);
    } on ServerException {
      return Left(ServerFailure('Lỗi máy chủ khi tải danh mục biển báo'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối mạng'));
    } catch (e) {
      return Left(ServerFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TrafficSignEntity>>> getTrafficSignsByGroup(
    String group,
  ) async {
    try {
      final remoteSigns = await remoteDataSource.getTrafficSignsByGroup(group);
      return Right(remoteSigns);
    } on ServerException {
      return Left(ServerFailure('Lỗi máy chủ khi tải danh sách biển báo'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối mạng'));
    } catch (e) {
      return Left(ServerFailure('Lỗi không xác định: $e'));
    }
  }
}
