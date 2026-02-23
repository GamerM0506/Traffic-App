import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/exam_detail_entity.dart';
import '../entities/exam_entity.dart';
import '../entities/exam_result_entity.dart';
import '../entities/exam_submission_entity.dart';

abstract class ExamRepository {
  Future<Either<Failure, List<ExamEntity>>> getExamsByType(String type);
  Future<Either<Failure, ExamDetailEntity>> getExamDetail(int id);
  Future<Either<Failure, ExamResultEntity>> submitExam(ExamSubmissionEntity submission);
  Future<Either<Failure, ExamDetailEntity>> getRandomExam(String type);
}
