import '../../domain/entities/answer_entity.dart';

class AnswerModel extends AnswerEntity {
  const AnswerModel({
    required super.id,
    required super.content,
    required super.isCorrect,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      isCorrect: json['isCorrect'] ?? false,
    );
  }
}
