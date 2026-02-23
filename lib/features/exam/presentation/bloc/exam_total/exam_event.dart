import 'package:equatable/equatable.dart';

abstract class ExamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamFetchList extends ExamEvent {
  final String type; // Ví dụ: "A1"

  ExamFetchList(this.type);

  @override
  List<Object?> get props => [type];
}