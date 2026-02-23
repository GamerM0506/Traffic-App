import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/ticker.dart';
import '../../../domain/entities/answer_entity.dart';
import '../../../domain/entities/exam_submission_detail_entity.dart';
import '../../../domain/entities/exam_submission_entity.dart';
import '../../../domain/usecases/calculate_score.dart';
import '../../../domain/usecases/get_exam_detail.dart';
import '../../../domain/usecases/get_random_exam.dart';
import 'exam_detail_event.dart';
import 'exam_detail_state.dart';
import 'dart:async';

class ExamDetailBloc extends Bloc<ExamDetailEvent, ExamDetailState> {
  final GetExamDetail _getExamDetail;
  final GetRandomExam _getRandomExam;
  final SubmitExam _submitExam;
  final Ticker _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;

  ExamDetailBloc({
    required GetExamDetail getExamDetail,
    required GetRandomExam getRandomExam,
    required SubmitExam submitExam,
  }) : _getExamDetail = getExamDetail,
       _getRandomExam = getRandomExam,
       _submitExam = submitExam,
       super(ExamDetailInitial()) {
    on<LoadExamDetailEvent>((event, emit) async {
      emit(ExamDetailLoading());
      final result = await _getExamDetail(event.examId);
      result.fold((failure) => emit(ExamDetailFailure(failure.message)), (
        data,
      ) {
        emit(ExamDetailLoaded(examDetail: data, timeLeft: 19 * 60));
        add(StartTimerEvent(19 * 60));
      });
    });

    on<LoadRandomExamEvent>((event, emit) async {
      emit(ExamDetailLoading());
      final result = await _getRandomExam(event.licenseType);

      result.fold(
              (failure) => emit(ExamDetailFailure(failure.message)),
              (examDetail) {
            if (examDetail.questions.isEmpty) {
              emit(ExamDetailFailure("Hệ thống chưa có dữ liệu câu hỏi cho hạng ${event.licenseType}!"));
              return;
            }
            emit(ExamDetailLoaded(examDetail: examDetail, timeLeft: 19 * 60));
            add(StartTimerEvent(19 * 60));
          }
      );
    });

    on<StartTimerEvent>((event, emit) {
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: event.duration)
          .listen((duration) => add(TimerTickedEvent(duration)));
    });

    on<TimerTickedEvent>((event, emit) {
      if (state is ExamDetailLoaded) {
        final currentState = state as ExamDetailLoaded;
        if (event.duration > 0) {
          emit(currentState.copyWith(timeLeft: event.duration));
        } else {
          emit(currentState.copyWith(timeLeft: 0));
        }
      }
    });

    on<ChangeQuestionEvent>((event, emit) {
      if (state is ExamDetailLoaded) {
        final currentState = state as ExamDetailLoaded;
        emit(currentState.copyWith(currentQuestionIndex: event.index));
      }
    });

    on<SelectAnswerEvent>((event, emit) {
      if (state is ExamDetailLoaded) {
        final currentState = state as ExamDetailLoaded;
        if (currentState.userAnswers.containsKey(event.questionId)) {
          return;
        }
        final newAnswers = Map<int, int>.from(currentState.userAnswers);
        newAnswers[event.questionId] = event.answerId;
        emit(currentState.copyWith(userAnswers: newAnswers));
      }
    });
    on<SubmitExamEvent>((event, emit) async {
      if (state is! ExamDetailLoaded) return;
      final currentState = state as ExamDetailLoaded;
      emit(ExamDetailSubmitting());
      final int totalSeconds = 19 * 60;
      final int durationSeconds = totalSeconds - currentState.timeLeft;
      int correctCount = 0;
      bool isParalysisFailed = false;
      List<ExamSubmissionDetailEntity> details = [];
      final questions = currentState.examDetail.questions;
      final userAnswers = currentState.userAnswers;
      for (var question in questions) {
        final userAnswerId = userAnswers[question.id];
        final correctAnswer = question.answers.cast<AnswerEntity>().firstWhere(
          (a) => a.isCorrect,
          orElse: () => question.answers.first,
        );
        final bool isCorrect = (userAnswerId == correctAnswer.id);
        if (isCorrect) {
          correctCount++;
        } else {
          if (question.isParalysis) isParalysisFailed = true;
        }
        details.add(
          ExamSubmissionDetailEntity(
            questionId: question.id,
            selectedAnswerId: userAnswerId,
            isCorrect: isCorrect,
          ),
        );
      }
      final submission = ExamSubmissionEntity(
        examSetId: currentState.examDetail.id,
        licenseType: event.licenseType,
        score: correctCount,
        totalQuestions: questions.length,
        isParalysisFailed: isParalysisFailed,
        durationSeconds: durationSeconds,
        details: details,
      );
      final result = await _submitExam(submission);
      result.fold(
        (failure) =>
            emit(ExamDetailFailure("Lỗi chấm điểm: ${failure.message}")),
        (successData) => emit(
          ExamSubmissionSuccess(
            result: successData,
            timeSpent: durationSeconds,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
