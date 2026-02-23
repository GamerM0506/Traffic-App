import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/exam_entity.dart';
import '../repositories/exam_repository.dart';

class GetExamsByType implements UseCase<List<ExamEntity>, String> {
  final ExamRepository repository;

  GetExamsByType(this.repository);

  @override
  Future<Either<Failure, List<ExamEntity>>> call(String type) async {
    return await repository.getExamsByType(type);
  }

}
