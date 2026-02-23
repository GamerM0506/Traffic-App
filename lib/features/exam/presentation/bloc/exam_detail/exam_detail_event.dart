import 'package:equatable/equatable.dart';

abstract class ExamDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadExamDetailEvent extends ExamDetailEvent {
  final int examId;
  LoadExamDetailEvent(this.examId);
}

class LoadRandomExamEvent extends ExamDetailEvent {
  final String licenseType;
  LoadRandomExamEvent(this.licenseType);
  @override
  List<Object?> get props => [licenseType];
}

class SelectAnswerEvent extends ExamDetailEvent {
  final int questionId;
  final int answerId;

  SelectAnswerEvent({required this.questionId, required this.answerId});
}

class ChangeQuestionEvent extends ExamDetailEvent {
  final int index;
  ChangeQuestionEvent(this.index);
}

class StartTimerEvent extends ExamDetailEvent {
  final int duration;
  StartTimerEvent(this.duration);
}

class TimerTickedEvent extends ExamDetailEvent {
  final int duration;
  TimerTickedEvent(this.duration);
}

class SubmitExamEvent extends ExamDetailEvent {
  final String licenseType;
  SubmitExamEvent(this.licenseType);
  @override
  List<Object?> get props => [licenseType];
}
