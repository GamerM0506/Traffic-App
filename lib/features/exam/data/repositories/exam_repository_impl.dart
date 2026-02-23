import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/exam_detail_entity.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/exam_result_entity.dart';
import '../../domain/entities/exam_submission_entity.dart';
import '../../domain/repositories/exam_repository.dart';
import '../datasources/exam_remote_data_source.dart';
import '../models/exam_submission_model.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamRemoteDataSource remoteDataSource;

  ExamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ExamEntity>>> getExamsByType(String type) async {
    try {
      final remoteExams = await remoteDataSource.getExamsByType(type);
      return Right(remoteExams);
    } on ServerException {
      return Left(ServerFailure('Lỗi máy chủ, không tải được bộ đề'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối mạng'));
    } catch (e) {
      return Left(ServerFailure('Đã xảy ra lỗi không mong muốn'));
    }
  }

  @override
  Future<Either<Failure, ExamDetailEntity>> getExamDetail(int id) async {
    try {
      final remoteExamDetail = await remoteDataSource.getExamDetail(id);
      return Right(remoteExamDetail);
    } on ServerException {
      return Left(ServerFailure('Lỗi máy chủ khi tải chi tiết đề'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối mạng'));
    } catch (e) {
      return Left(ServerFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Future<Either<Failure, ExamResultEntity>> submitExam(
    ExamSubmissionEntity submission,
  ) async {
    try {
      final submissionModel = ExamSubmissionModel.fromEntity(submission);
      final resultModel = await remoteDataSource.submitExam(submissionModel);
      return Right(resultModel);
    } on ServerException {
      return Left(ServerFailure("Lỗi máy chủ khi chấm điểm"));
    } catch (e) {
      return Left(ServerFailure("Lỗi kết nối: $e"));
    }
  }

  @override
  Future<Either<Failure, ExamDetailEntity>> getRandomExam(String type) async {
    try {
      final remoteRandomExam = await remoteDataSource.getRandomExam(type);
      return Right(remoteRandomExam);
    } on ServerException {
      return Left(ServerFailure('Lỗi máy chủ khi tạo đề ngẫu nhiên'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Lỗi kết nối mạng'));
    } catch (e) {
      return Left(ServerFailure('Lỗi không xác định: $e'));
    }
  }
}
