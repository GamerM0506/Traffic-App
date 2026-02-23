import 'package:equatable/equatable.dart';

class ExamResultEntity extends Equatable {
  final String status;
  final int score;
  final int totalQuestions;
  final bool isParalysisFailed;
  final String message;

  const ExamResultEntity({
    required this.status,
    required this.score,
    required this.totalQuestions,
    required this.isParalysisFailed,
    required this.message,
  });

  bool get isPassed => status == "PASS";

  @override
  List<Object?> get props => [
    status,
    score,
    totalQuestions,
    isParalysisFailed,
    message,
  ];
}
