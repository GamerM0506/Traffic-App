import '../../domain/entities/traffic_sign_entity.dart';

class TrafficSignModel extends TrafficSignEntity {
  const TrafficSignModel({
    required super.id,
    required super.code,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.group,
  });

  factory TrafficSignModel.fromJson(Map<String, dynamic> json) {
    return TrafficSignModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      group: json['group'] ?? '',
    );
  }
}
