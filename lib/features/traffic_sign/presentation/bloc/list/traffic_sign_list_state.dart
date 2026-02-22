import 'package:equatable/equatable.dart';
import '../../../domain/entities/traffic_sign_entity.dart';

abstract class TrafficSignListState extends Equatable {
  const TrafficSignListState();

  @override
  List<Object?> get props => [];
}

class TrafficSignListInitial extends TrafficSignListState {}

class TrafficSignListLoading extends TrafficSignListState {}

class TrafficSignListLoaded extends TrafficSignListState {
  final List<TrafficSignEntity> signs;

  const TrafficSignListLoaded(this.signs);

  @override
  List<Object?> get props => [signs];
}

class TrafficSignListFailure extends TrafficSignListState {
  final String message;

  const TrafficSignListFailure(this.message);

  @override
  List<Object?> get props => [message];
}
