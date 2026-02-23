import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_exams_by_type.dart';
import 'exam_event.dart';
import 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final GetExamsByType _getExamsByType;

  ExamBloc({required GetExamsByType getExamsByType})
    : _getExamsByType = getExamsByType,
      super(ExamInitial()) {
    on<ExamFetchList>((event, emit) async {
      emit(ExamLoading());

      final result = await _getExamsByType(event.type);

      result.fold(
        (failure) => emit(ExamFailure(failure.message)),
        (data) => emit(ExamLoaded(data)),
      );
    });
  }
}
