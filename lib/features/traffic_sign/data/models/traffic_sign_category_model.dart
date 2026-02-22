import '../../domain/entities/traffic_sign_category_entity.dart';

class TrafficSignCategoryModel extends TrafficSignCategoryEntity {
  const TrafficSignCategoryModel({required super.code});

  factory TrafficSignCategoryModel.fromJson(String json) {
    return TrafficSignCategoryModel(code: json);
  }
}
