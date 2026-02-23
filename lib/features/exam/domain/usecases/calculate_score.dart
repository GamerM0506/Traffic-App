import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/exam_result_entity.dart';
import '../entities/exam_submission_entity.dart';
import '../repositories/exam_repository.dart';

class SubmitExam implements UseCase<ExamResultEntity, ExamSubmissionEntity> {
  final ExamRepository repository;

  SubmitExam(this.repository);

  @override
  Future<Either<Failure, ExamResultEntity>> call(
    ExamSubmissionEntity params,
  ) async {
    return await repository.submitExam(params);
  }
}
