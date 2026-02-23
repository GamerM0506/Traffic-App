import 'package:equatable/equatable.dart';

class ExamSubmissionDetailEntity extends Equatable {
  final int questionId;
  final int? selectedAnswerId;
  final bool isCorrect;

  const ExamSubmissionDetailEntity({
    required this.questionId,
    this.selectedAnswerId,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswerId, isCorrect];
}
