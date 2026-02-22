import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_traffic_signs_by_group.dart';
import 'traffic_sign_list_event.dart';
import 'traffic_sign_list_state.dart';

class TrafficSignListBloc
    extends Bloc<TrafficSignListEvent, TrafficSignListState> {
  final GetTrafficSignsByGroup _getTrafficSignsByGroup;

  TrafficSignListBloc({required GetTrafficSignsByGroup getTrafficSignsByGroup})
    : _getTrafficSignsByGroup = getTrafficSignsByGroup,
      super(TrafficSignListInitial()) {
    on<GetTrafficSignsEvent>((event, emit) async {
      emit(TrafficSignListLoading());
      final result = await _getTrafficSignsByGroup(event.group);
      result.fold(
        (failure) => emit(TrafficSignListFailure(failure.message)),
        (signs) => emit(TrafficSignListLoaded(signs)),
      );
    });
  }
}
