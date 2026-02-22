import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/traffic_sign_category_entity.dart';
import '../repositories/traffic_sign_repository.dart';

class GetTrafficSignCategories implements UseCase<List<TrafficSignCategoryEntity>, NoParams> {
  final TrafficSignRepository repository;

  GetTrafficSignCategories(this.repository);

  @override
  Future<Either<Failure, List<TrafficSignCategoryEntity>>> call(NoParams params) async {
    return await repository.getTrafficSignCategories();
  }
}