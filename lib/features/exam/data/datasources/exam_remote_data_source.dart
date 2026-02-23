import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../models/exam_submission_model.dart';
import '../models/exam_detail_model.dart';
import '../models/exam_model.dart';

abstract class ExamRemoteDataSource {
  Future<List<ExamModel>> getExamsByType(String type);
  Future<ExamDetailModel> getExamDetail(int id);
  Future<ExamResultModel> submitExam(ExamSubmissionModel submission);
  Future<ExamDetailModel> getRandomExam(String licenseType);
}

class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final Dio dio;
  ExamRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ExamModel>> getExamsByType(String type) async {
    try {
      final response = await dio.get('/exams', queryParameters: {'type': type});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ExamModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ExamDetailModel> getExamDetail(int id) async {
    try {
      final response = await dio.get('/exams/$id');
      if (response.statusCode == 200) {
        return ExamDetailModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("Lỗi API getExamDetail: $e");
      throw ServerException();
    }
  }

  @override
  Future<ExamResultModel> submitExam(ExamSubmissionModel submission) async {
    try {
      final response = await dio.post(
        '/test-history/calculate',
        data: submission.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ExamResultModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("API Error submitExam: $e");
      throw ServerException();
    }
  }

  @override
  Future<ExamDetailModel> getRandomExam(String licenseType) async {
    final response = await dio.get(
      '/exams/random',
      queryParameters: {'type': licenseType},
    );
    return ExamDetailModel.fromJson(response.data);
  }
}
