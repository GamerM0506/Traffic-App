import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/exam_detail_entity.dart';
import '../repositories/exam_repository.dart';

class GetRandomExam implements UseCase<ExamDetailEntity, String> {
  final ExamRepository repository;
  GetRandomExam(this.repository);

  @override
  Future<Either<Failure, ExamDetailEntity>> call(String licenseType) async {
    return await repository.getRandomExam(licenseType);
  }
}
