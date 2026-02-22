import 'package:equatable/equatable.dart';

abstract class TrafficSignListEvent extends Equatable {
  const TrafficSignListEvent();

  @override
  List<Object?> get props => [];
}

class GetTrafficSignsEvent extends TrafficSignListEvent {
  final String group;

  const GetTrafficSignsEvent(this.group);

  @override
  List<Object?> get props => [group];
}