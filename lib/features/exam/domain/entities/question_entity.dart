import 'package:equatable/equatable.dart';
import 'answer_entity.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String content;
  final String explanation;
  final bool isParalysis;
  final String? mediaUrl;
  final String mediaType;
  final List<AnswerEntity> answers;

  const QuestionEntity({
    required this.id,
    required this.content,
    required this.explanation,
    required this.isParalysis,
    this.mediaUrl,
    required this.mediaType,
    required this.answers,
  });

  @override
  List<Object?> get props => [
    id,
    content,
    explanation,
    isParalysis,
    mediaUrl,
    mediaType,
    answers,
  ];
}
