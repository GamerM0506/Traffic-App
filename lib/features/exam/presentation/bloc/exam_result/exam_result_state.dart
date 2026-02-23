import 'package:equatable/equatable.dart';

abstract class ExamResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamResultInitial extends ExamResultState {}

class ExamResultSaving extends ExamResultState {}

class ExamResultSavedSuccess extends ExamResultState {}

class ExamResultSavedFailure extends ExamResultState {
  final String message;
  final bool requireLogin;

  ExamResultSavedFailure(this.message, {this.requireLogin = false});

  @override
  List<Object?> get props => [message, requireLogin];
}
