import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traffic_app/core/usecases/usecase.dart';
import 'package:traffic_app/features/license/domain/usecases/get_categories_usecase.dart';
import 'package:traffic_app/features/license/presentation/bloc/license_event.dart';
import 'package:traffic_app/features/license/presentation/bloc/license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  LicenseBloc({required GetCategoriesUseCase getCategoriesUseCase})
    : _getCategoriesUseCase = getCategoriesUseCase,
      super(LicenseInitial()) {
    on<LicenseFetchData>((event, emit) async {
      emit(LicenseLoading());
      final result = await _getCategoriesUseCase(NoParams());

      result.fold(
        (failure) => emit(LicenseFailure(failure.message)),
        (data) => emit(LicenseLoaded(data)),
      );
    });
  }
}
