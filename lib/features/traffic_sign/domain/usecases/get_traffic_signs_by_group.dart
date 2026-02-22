import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/traffic_sign_entity.dart';
import '../repositories/traffic_sign_repository.dart';

class GetTrafficSignsByGroup
    implements UseCase<List<TrafficSignEntity>, String> {
  final TrafficSignRepository repository;

  GetTrafficSignsByGroup(this.repository);

  @override
  Future<Either<Failure, List<TrafficSignEntity>>> call(String group) async {
    return await repository.getTrafficSignsByGroup(group);
  }
}
