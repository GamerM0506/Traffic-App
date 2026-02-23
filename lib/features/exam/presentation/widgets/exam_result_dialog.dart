import 'package:flutter/material.dart';
import 'package:traffic_app/features/exam/data/models/exam_submission_model.dart';

class ExamResultDialog extends StatelessWidget {
  final ExamSubmissionModel resultData;
  final VoidCallback onExit;
  final VoidCallback onSave;

  const ExamResultDialog({
    super.key,
    required this.resultData,
    required this.onExit,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPassed = resultData.isPassed;
    final Color statusColor = isPassed ? Colors.green : Colors.red;
    final IconData statusIcon = isPassed ? Icons.check_circle : Icons.cancel;
    final String title = isPassed ? "ĐẠT" : "KHÔNG ĐẠT";
    String message = isPassed
        ? "Chúc mừng! Bạn đã vượt qua bài thi."
        : "Rất tiếc, hãy cố gắng lần sau nhé!";

    if (resultData.isParalysisFailed) {
      message = "Bạn đã trả lời sai câu điểm liệt!";
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Icon(statusIcon, size: 80, color: statusColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: resultData.isParalysisFailed ? Colors.red : Colors.grey[700],
              fontStyle: resultData.isParalysisFailed ? FontStyle.italic : FontStyle.normal,
              fontWeight: resultData.isParalysisFailed ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          _buildResultRow(
            label: "Kết quả:",
            value: "${resultData.score}/${resultData.totalQuestions}",
            valueColor: statusColor,
            isBold: true,
          ),
          const SizedBox(height: 10),
          if (resultData.isParalysisFailed)
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 16, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Text(
                    "Sai câu điểm liệt",
                    style: TextStyle(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      actions: [
        OutlinedButton(
          onPressed: onExit,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: BorderSide(color: Colors.grey.shade400),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("Thoát", style: TextStyle(color: Colors.black54)),
        ),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text(
            "Kết thúc", // Hoặc "Lưu" tùy logic sếp
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: valueColor ?? Colors.black87
          ),
        ),
      ],
    );
  }
}