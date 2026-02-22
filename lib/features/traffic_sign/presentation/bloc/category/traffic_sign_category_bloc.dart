import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_traffic_sign_categories.dart';
import 'traffic_sign_category_event.dart';
import 'traffic_sign_category_state.dart';

class TrafficSignCategoryBloc
    extends Bloc<TrafficSignCategoryEvent, TrafficSignCategoryState> {
  final GetTrafficSignCategories _getTrafficSignCategories;

  TrafficSignCategoryBloc({
    required GetTrafficSignCategories getTrafficSignCategories,
  }) : _getTrafficSignCategories = getTrafficSignCategories,
       super(TrafficSignCategoryInitial()) {
    on<GetTrafficSignCategoriesEvent>((event, emit) async {
      emit(TrafficSignCategoryLoading());
      final result = await _getTrafficSignCategories(NoParams());
      result.fold(
        (failure) => emit(TrafficSignCategoryFailure(failure.message)),
        (categories) => emit(TrafficSignCategoryLoaded(categories)),
      );
    });
  }
}
