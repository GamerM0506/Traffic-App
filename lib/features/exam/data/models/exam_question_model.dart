import '../../domain/entities/question_entity.dart';
import 'exam_answer_model.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.content,
    required super.explanation,
    required super.isParalysis,
    super.mediaUrl,
    required super.mediaType,
    required super.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      explanation: json['explanation'] ?? '',
      isParalysis: json['isParalysis'] ?? false,
      mediaUrl: json['mediaUrl'],
      mediaType: json['mediaType'] ?? 'TEXT',
      answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}