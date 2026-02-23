import 'package:flutter/material.dart';
import '../../domain/entities/answer_entity.dart';

class AnswerList extends StatelessWidget {
  final List<AnswerEntity> answers;
  final int? selectedAnswerId; // ID user chọn
  final Function(int) onSelect;

  const AnswerList({
    super.key,
    required this.answers,
    required this.selectedAnswerId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasAnswered = selectedAnswerId != null;

    return Column(
      children: answers.map((answer) {
        Color bgColor = Colors.white;
        Color borderColor = Colors.grey.shade300;
        Color textColor = Colors.black87;
        IconData? statusIcon;
        Color iconColor = Colors.transparent;

        if (hasAnswered) {
          if (answer.isCorrect) {
            bgColor = Colors.green.shade50;
            borderColor = Colors.green;
            textColor = Colors.green.shade900;
            statusIcon = Icons.check_circle;
            iconColor = Colors.green;
          } else if (selectedAnswerId == answer.id) {
            bgColor = Colors.red.shade50;
            borderColor = Colors.red;
            textColor = Colors.red.shade900;
            statusIcon = Icons.cancel;
            iconColor = Colors.red;
          } else {
            textColor = Colors.grey.shade400;
          }
        } else {
          if (selectedAnswerId == answer.id) {
            borderColor = Colors.blue;
            bgColor = Colors.blue.shade50;
          }
        }
        return GestureDetector(
          onTap: hasAnswered ? null : () => onSelect(answer.id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: hasAnswered ? 2 : 1),
            ),
            child: Row(
              children: [
                if (statusIcon != null)
                  Icon(statusIcon, color: iconColor, size: 24)
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    answer.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: (hasAnswered && (answer.isCorrect || selectedAnswerId == answer.id))
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}