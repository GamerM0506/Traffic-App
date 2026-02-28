import 'package:flutter/material.dart';

class ExamHeader extends StatelessWidget {
  final int currentIndex;
  final int total;
  final int timeLeft;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  const ExamHeader({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.timeLeft,
    required this.onClose,
    required this.onSubmit,
  });

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isTimeRunningOut = timeLeft <= 60;
    final timerColor = isTimeRunningOut ? Colors.red : Colors.deepOrange;
    final timerBgColor = isTimeRunningOut
        ? Colors.red.shade50
        : Colors.orange.shade50;
    final timerBorderColor = isTimeRunningOut
        ? Colors.red.shade200
        : Colors.orange.shade200;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.close, color: Colors.grey),
            ),
          ),
          Text(
            "Câu ${currentIndex + 1}/$total",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: timerBgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: timerBorderColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 16, color: timerColor),
                    const SizedBox(width: 5),
                    Text(
                      _formatTime(timeLeft),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: timerColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  fixedSize: const Size.fromHeight(36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "NỘP BÀI",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}