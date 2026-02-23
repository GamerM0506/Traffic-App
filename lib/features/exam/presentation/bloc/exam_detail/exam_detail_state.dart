import 'package:equatable/equatable.dart';

import '../../../domain/entities/exam_detail_entity.dart';
import '../../../domain/entities/exam_result_entity.dart';

abstract class ExamDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamDetailInitial extends ExamDetailState {}

class ExamDetailLoading extends ExamDetailState {}

class ExamDetailLoaded extends ExamDetailState {
  final ExamDetailEntity examDetail;
  final int currentQuestionIndex;
  final Map<int, int> userAnswers;
  final int timeLeft;

  ExamDetailLoaded({
    required this.examDetail,
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
    this.timeLeft = 1140,
  });

  ExamDetailLoaded copyWith({
    ExamDetailEntity? examDetail,
    int? currentQuestionIndex,
    Map<int, int>? userAnswers,
    int? timeLeft,
  }) {
    return ExamDetailLoaded(
      examDetail: examDetail ?? this.examDetail,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      timeLeft: timeLeft ?? this.timeLeft,
    );
  }

  @override
  List<Object?> get props => [
    examDetail,
    currentQuestionIndex,
    userAnswers,
    timeLeft,
  ];
}

class ExamDetailFailure extends ExamDetailState {
  final String message;
  ExamDetailFailure(this.message);
}

class ExamDetailSubmitting extends ExamDetailState {}

class ExamSubmissionSuccess extends ExamDetailState {
  final ExamResultEntity result;
  final int timeSpent;

  ExamSubmissionSuccess({
    required this.result,
    required this.timeSpent,
  });
  @override
  List<Object?> get props => [result, timeSpent];
}
