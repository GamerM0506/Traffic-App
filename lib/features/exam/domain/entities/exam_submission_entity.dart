import 'package:equatable/equatable.dart';

import 'exam_submission_detail_entity.dart';

class ExamSubmissionEntity extends Equatable {
  final int examSetId;
  final String licenseType;
  final int score;
  final int totalQuestions;
  final bool isParalysisFailed;
  final int durationSeconds;
  final List<ExamSubmissionDetailEntity> details;
  final bool isPassed;

  const ExamSubmissionEntity({
    required this.examSetId,
    required this.licenseType,
    required this.score,
    required this.totalQuestions,
    required this.isParalysisFailed,
    required this.durationSeconds,
    required this.details,
    this.isPassed = false,
  });

  @override
  List<Object?> get props => [
    examSetId,
    licenseType,
    score,
    totalQuestions,
    isParalysisFailed,
    durationSeconds,
    details,
    isPassed
  ];
}
