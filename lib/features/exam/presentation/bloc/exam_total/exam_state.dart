import 'package:equatable/equatable.dart';
import '../../../domain/entities/exam_entity.dart';

abstract class ExamState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final List<ExamEntity> exams;

  ExamLoaded(this.exams);

  @override
  List<Object?> get props => [exams];
}

class ExamFailure extends ExamState {
  final String message;

  ExamFailure(this.message);

  @override
  List<Object?> get props => [message];
}
