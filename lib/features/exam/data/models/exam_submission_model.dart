import '../../domain/entities/exam_result_entity.dart';
import '../../domain/entities/exam_submission_entity.dart';

class ExamSubmissionModel extends ExamSubmissionEntity {
  const ExamSubmissionModel({
    required super.examSetId,
    required super.licenseType,
    required super.score,
    required super.totalQuestions,
    required super.isParalysisFailed,
    required super.durationSeconds,
    required super.details,
    super.isPassed,
  });

  factory ExamSubmissionModel.fromEntity(ExamSubmissionEntity entity) {
    return ExamSubmissionModel(
      examSetId: entity.examSetId,
      licenseType: entity.licenseType,
      score: entity.score,
      totalQuestions: entity.totalQuestions,
      isParalysisFailed: entity.isParalysisFailed,
      durationSeconds: entity.durationSeconds,
      details: entity.details,
      isPassed: entity.isPassed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examSetId': examSetId,
      'licenseType': licenseType,
      'score': score,
      'totalQuestions': totalQuestions,
      'isParalysisFailed': isParalysisFailed,
      'durationSeconds': durationSeconds,
      'details': details
          .map(
            (e) => {
              'questionId': e.questionId,
              'selectedAnswerId': e.selectedAnswerId,
              'isCorrect': e.isCorrect,
            },
          )
          .toList(),
    };
  }
}

class ExamResultModel extends ExamResultEntity {
  const ExamResultModel({
    required super.status,
    required super.score,
    required super.totalQuestions,
    required super.isParalysisFailed,
    required super.message,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) {
    return ExamResultModel(
      status: json['status'] ?? 'FAIL',
      score: json['score'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      isParalysisFailed: json['isParalysisFailed'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
