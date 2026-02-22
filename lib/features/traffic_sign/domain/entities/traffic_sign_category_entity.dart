import 'package:equatable/equatable.dart';

class TrafficSignCategoryEntity extends Equatable {
  final String code;
  
  const TrafficSignCategoryEntity({required this.code});

  @override
  List<Object?> get props => [code];
}