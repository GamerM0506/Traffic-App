import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/exam_detail_entity.dart';
import '../repositories/exam_repository.dart';

class GetExamDetail implements UseCase<ExamDetailEntity, int> {
  final ExamRepository repository;

  GetExamDetail(this.repository);

  @override
  Future<Either<Failure, ExamDetailEntity>> call(int id) async {
    return await repository.getExamDetail(id);
  }
}
