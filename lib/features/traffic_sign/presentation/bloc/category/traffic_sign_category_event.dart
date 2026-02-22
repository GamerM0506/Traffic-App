import 'package:equatable/equatable.dart';

abstract class TrafficSignCategoryEvent extends Equatable {
  const TrafficSignCategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetTrafficSignCategoriesEvent extends TrafficSignCategoryEvent {}
