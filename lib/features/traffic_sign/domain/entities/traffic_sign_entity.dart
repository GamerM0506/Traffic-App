import 'package:equatable/equatable.dart';

class TrafficSignEntity extends Equatable {
  final int id;
  final String code;
  final String name;
  final String description;
  final String imageUrl;
  final String group;

  const TrafficSignEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.group,
  });

  @override
  List<Object?> get props => [id, code, name, description, imageUrl, group];
}
