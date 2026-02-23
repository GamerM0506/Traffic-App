import 'package:equatable/equatable.dart';

class AnswerEntity extends Equatable {
  final int id;
  final String content;
  final bool isCorrect;

  const AnswerEntity({
    required this.id,
    required this.content,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [id, content, isCorrect];
}
