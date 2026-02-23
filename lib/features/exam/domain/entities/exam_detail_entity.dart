import 'package:equatable/equatable.dart';
import 'question_entity.dart';

class ExamDetailEntity extends Equatable {
  final int id;
  final String name;
  final List<QuestionEntity> questions;

  const ExamDetailEntity({
    required this.id,
    required this.name,
    required this.questions,
  });

  @override
  List<Object?> get props => [id, name, questions];
}
