import '../../domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity {
  const ExamModel({
    required super.id,
    required super.title,
    required super.description,
    required super.questionCount,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questionCount: json['questionCount'] ?? 25,
    );
  }
}
