import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../data/models/exam_submission_model.dart';
import '../../domain/entities/exam_result_entity.dart';
import '../bloc/exam_detail/exam_detail_bloc.dart';
import '../bloc/exam_detail/exam_detail_event.dart';
import '../bloc/exam_detail/exam_detail_state.dart';
import '../widgets/exam_detail_footer.dart';
import '../widgets/exam_detail_header.dart';
import '../widgets/exam_detail_list.dart';
import '../widgets/exam_detail_question.dart';
import '../widgets/exam_result_dialog.dart';

class DoExamPage extends StatelessWidget {
  final int examId;
  final String licenseType;
  final bool isRandom;

  const DoExamPage({
    super.key,
    required this.examId,
    required this.licenseType,
    this.isRandom = false,
  });

  void _showExitConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thoát bài thi?"),
        content: const Text(
          "Toàn bộ quá trình làm bài sẽ bị hủy và không được lưu lại.\nBạn có chắc chắn muốn thoát?",
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Ở lại", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text(
              "Thoát",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePreSubmit(BuildContext context, ExamDetailLoaded state) {
    final int total = state.examDetail.questions.length;
    final int answered = state.userAnswers.length;
    final int unanswered = total - answered;

    if (unanswered > 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Chưa hoàn thành",
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            "Bạn còn $unanswered câu chưa trả lời.\nVui lòng hoàn thành hết trước khi nộp bài.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Đã hiểu"),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nộp bài thi?"),
        content: const Text(
          "Bạn có chắc chắn muốn nộp bài và xem kết quả ngay?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Xem lại", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // Tắt popup
              context.read<ExamDetailBloc>().add(SubmitExamEvent(licenseType));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text("Nộp bài", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showResultDialog(BuildContext context, ExamResultEntity result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => ExamResultDialog(
        resultData: ExamSubmissionModel(
          examSetId: examId,
          licenseType: licenseType,
          score: result.score,
          totalQuestions: result.totalQuestions,
          isParalysisFailed: result.isParalysisFailed,
          isPassed: result.status == "PASS",
          details: [],
          durationSeconds: 0,
        ),
        onExit: () {
          Navigator.pop(ctx);
          Navigator.pop(context);
        },
        onSave: () {
          Navigator.pop(ctx);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<ExamDetailBloc>();
        if (isRandom) {
          bloc.add(LoadRandomExamEvent(licenseType));
        } else {
          bloc.add(LoadExamDetailEvent(examId));
        }

        return bloc;
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          _showExitConfirmDialog(context);
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: BlocConsumer<ExamDetailBloc, ExamDetailState>(
            listener: (context, state) {
              if (state is ExamSubmissionSuccess) {
                _showResultDialog(context, state.result);
              } else if (state is ExamDetailFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ExamDetailSubmitting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Đang chấm điểm..."),
                    ],
                  ),
                );
              }
              if (state is ExamDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExamDetailFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 80),
                        const SizedBox(height: 20),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text("Quay lại"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is ExamDetailLoaded) {
                final question =
                    state.examDetail.questions[state.currentQuestionIndex];
                final total = state.examDetail.questions.length;
                final selectedAnswerId = state.userAnswers[question.id];
                return SafeArea(
                  child: Column(
                    children: [
                      ExamHeader(
                        currentIndex: state.currentQuestionIndex,
                        total: total,
                        timeLeft: state.timeLeft,
                        onClose: () => _showExitConfirmDialog(context),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (question.isParalysis)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.yellow,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Câu điểm liệt",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              QuestionContent(
                                question: question,
                                index: state.currentQuestionIndex,
                              ),
                              const SizedBox(height: 20),
                              AnswerList(
                                answers: question.answers,
                                selectedAnswerId: selectedAnswerId,
                                onSelect: (answerId) {
                                  context.read<ExamDetailBloc>().add(
                                    SelectAnswerEvent(
                                      questionId: question.id,
                                      answerId: answerId,
                                    ),
                                  );
                                },
                              ),
                              if (selectedAnswerId != null) ...[
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.orange.shade200,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Giải thích đáp án",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        question.explanation.isNotEmpty
                                            ? question.explanation
                                            : "Chưa có giải thích cho câu này.",
                                        style: const TextStyle(height: 1.4),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20), // Padding đáy
                              ],
                            ],
                          ),
                        ),
                      ),
                      ExamFooter(
                        isFirstQuestion: state.currentQuestionIndex == 0,
                        isLastQuestion: state.currentQuestionIndex == total - 1,
                        onPrevious: () {
                          context.read<ExamDetailBloc>().add(
                            ChangeQuestionEvent(state.currentQuestionIndex - 1),
                          );
                        },
                        onNext: () {
                          context.read<ExamDetailBloc>().add(
                            ChangeQuestionEvent(state.currentQuestionIndex + 1),
                          );
                        },
                        onSubmit: () => _handlePreSubmit(context, state),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
