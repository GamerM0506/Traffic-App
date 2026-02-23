import 'package:flutter/material.dart';

class ExamFooter extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final bool isFirstQuestion;
  final bool isLastQuestion;

  const ExamFooter({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Row(
        children: [
          // Nút Câu trước
          Expanded(
            child: OutlinedButton(
              onPressed: isFirstQuestion ? null : onPrevious,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Câu trước"),
            ),
          ),

          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: isLastQuestion ? onSubmit : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastQuestion ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                isLastQuestion ? "NỘP BÀI" : "Câu sau",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}