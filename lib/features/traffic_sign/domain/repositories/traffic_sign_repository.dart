import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/traffic_sign_category_entity.dart';
import '../entities/traffic_sign_entity.dart';

abstract class TrafficSignRepository {
  Future<Either<Failure, List<TrafficSignCategoryEntity>>> getTrafficSignCategories();
  Future<Either<Failure, List<TrafficSignEntity>>> getTrafficSignsByGroup(String group);
}