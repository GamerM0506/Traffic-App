import '../../domain/entities/license_entity.dart';

class LicenseCategoryModel extends LicenseCategoryEntity {
  const LicenseCategoryModel({
    required super.type,
    required super.name,
    required super.description,
    required super.totalExams,
  });
  factory LicenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return LicenseCategoryModel(
      type: json['type'],
      name: json['name'],
      description: json['description'],
      totalExams: json['totalExams'],
    );
  }
}
