import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../injection_container.dart';
import '../bloc/exam_total/exam_bloc.dart';
import '../bloc/exam_total/exam_event.dart';
import '../bloc/exam_total/exam_state.dart';
import '../widgets/exam_item_card.dart';

class ExamListPage extends StatelessWidget {
  final String licenseType;

  const ExamListPage({super.key, required this.licenseType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ExamBloc>()..add(ExamFetchList(licenseType)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bộ đề thi $licenseType"),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocConsumer<ExamBloc, ExamState>(
          listener: (context, state) {
            if (state is ExamLoaded && state.exams.isEmpty) {
              _showEmptyDialog(context);
            } else if (state is ExamFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Lỗi: ${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ExamLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ExamLoaded) {
              if (state.exams.isEmpty) {
                return const Center(child: Text("Đang tải dữ liệu..."));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  final exam = state.exams[index];
                  return ExamItemCard(
                    exam: exam,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.doExam,
                        arguments: {
                          'id': exam.id,
                          'type': licenseType
                        },
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showEmptyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Thông báo"),
        content: Text(
          "Hiện tại chưa có bộ đề nào cho hạng $licenseType.\nVui lòng quay lại sau!",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Đồng ý"),
          ),
        ],
      ),
    );
  }
}
