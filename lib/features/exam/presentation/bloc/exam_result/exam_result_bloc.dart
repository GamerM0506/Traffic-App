import 'package:flutter_bloc/flutter_bloc.dart';
import 'exam_result_event.dart';
import 'exam_result_state.dart';

class ExamResultBloc extends Bloc<ExamResultEvent, ExamResultState> {

  ExamResultBloc() : super(ExamResultInitial()) {
    on<SaveExamResultEvent>((event, emit) async {
      emit(ExamResultSaving());

      // --- 1. MÔ PHỎNG CHECK LOGIN ---
      // Sau này: final isLoggedIn = authBloc.state.isLoggedIn;
      bool isLoggedIn = false; // Tạm thời fix cứng để test logic

      await Future.delayed(const Duration(milliseconds: 500)); // Delay cho thật

      if (!isLoggedIn) {
        emit(
          ExamResultSavedFailure(
            "Vui lòng đăng nhập để lưu kết quả!",
            requireLogin: true,
          ),
        );
        return;
      }

      // --- 2. MÔ PHỎNG GỌI API LƯU ---
      try {
        // await saveExamUseCase(event.submission);
        print("Đã lưu kết quả: ${event.submission.toJson()}");

        emit(ExamResultSavedSuccess());
      } catch (e) {
        emit(ExamResultSavedFailure("Lỗi khi lưu kết quả: $e"));
      }
    });
  }
}
