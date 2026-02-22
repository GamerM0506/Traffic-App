import 'package:equatable/equatable.dart';
import '../../../domain/entities/traffic_sign_category_entity.dart';

abstract class TrafficSignCategoryState extends Equatable {
  const TrafficSignCategoryState();

  @override
  List<Object?> get props => [];
}

class TrafficSignCategoryInitial extends TrafficSignCategoryState {}

class TrafficSignCategoryLoading extends TrafficSignCategoryState {}

class TrafficSignCategoryLoaded extends TrafficSignCategoryState {
  final List<TrafficSignCategoryEntity> categories;

  const TrafficSignCategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class TrafficSignCategoryFailure extends TrafficSignCategoryState {
  final String message;

  const TrafficSignCategoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
