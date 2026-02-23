import 'package:equatable/equatable.dart';
import '../../../data/models/exam_submission_model.dart';

abstract class ExamResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveExamResultEvent extends ExamResultEvent {
  final ExamSubmissionModel submission;

  SaveExamResultEvent(this.submission);

  @override
  List<Object?> get props => [submission];
}
