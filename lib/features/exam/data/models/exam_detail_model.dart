import '../../domain/entities/exam_detail_entity.dart';
import 'exam_question_model.dart';

class ExamDetailModel extends ExamDetailEntity {
  const ExamDetailModel({
    required super.id,
    required super.name,
    required super.questions,
  });

  factory ExamDetailModel.fromJson(Map<String, dynamic> json) {
    return ExamDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
