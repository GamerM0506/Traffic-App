import 'package:flutter/material.dart';

class ExamFooter extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isFirstQuestion;
  final bool isLastQuestion;
  final int totalQuestions;
  final Set<int> answeredIndices;
  final Function(int) onJump;
  final int currentIndex;

  const ExamFooter({
    super.key,
    required this.onPrevious,
    required this.onNext,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
    required this.totalQuestions,
    required this.answeredIndices,
    required this.onJump,
    required this.currentIndex,
  });

  void _showQuestionGrid(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 32),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text("Danh sách câu hỏi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend(Colors.green, "Đã làm", borderColor: Colors.green),
                  const SizedBox(width: 12),
                  _buildLegend(Colors.blue.shade50, "Đang xem", borderColor: Colors.blue),
                  const SizedBox(width: 12),
                  _buildLegend(Colors.red.shade50, "Chưa làm", borderColor: Colors.red.shade200),
                ],
              ),
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: totalQuestions,
                    itemBuilder: (context, index) {
                      final isAnswered = answeredIndices.contains(index);
                      final isCurrent = index == currentIndex;

                      Color bgColor = Colors.red.shade50;
                      Color borderColor = Colors.red.shade200;
                      Color textColor = Colors.red.shade700;

                      if (isCurrent) {
                        bgColor = Colors.blue.shade50;
                        borderColor = Colors.blue;
                        textColor = Colors.blue.shade700;
                      } else if (isAnswered) {
                        bgColor = Colors.green;
                        borderColor = Colors.green;
                        textColor = Colors.white;
                      }

                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          onJump(index);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: borderColor, width: isCurrent ? 2.0 : 1.2),
                          ),
                          child: Text("${index + 1}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegend(Color color, String text, {Color? borderColor}) {
    return Row(
      children: [
        Container(
          width: 14, height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4), border: borderColor != null ? Border.all(color: borderColor, width: 1.2) : null),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: isFirstQuestion ? null : onPrevious,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.black87,
                  disabledBackgroundColor: Colors.grey.shade50,
                  disabledForegroundColor: Colors.grey.shade300,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showQuestionGrid(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  foregroundColor: Colors.blue.shade700,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: Colors.blue.shade200, width: 1.2),
                ),
                child: const Icon(Icons.grid_view_rounded, size: 26),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isLastQuestion ? null : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  disabledForegroundColor: Colors.grey.shade400,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}