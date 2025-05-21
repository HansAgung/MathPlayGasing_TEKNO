// File: answer_grid_stateful.dart
import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../../../features/data/models/option_question_model.dart';

class AnswerGrid extends StatelessWidget {
  final List<OptionModel> answers;
  final String? selectedAnswer;
  final String correctAnswer;
  final bool showAnswerResult;
  final Function(String) onSelect;

  const AnswerGrid({
    super.key,
    required this.answers,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.showAnswerResult,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final answer = answers[index];
        final isSelected = selectedAnswer == answer.optionId;
        final isCorrect = answer.optionId == correctAnswer;

        Color bgColor = Colors.white;
        if (showAnswerResult) {
          if (isCorrect) {
            bgColor = AppColors.greenDark;
          } else if (isSelected && !isCorrect) {
            bgColor = const Color.fromARGB(255, 223, 133, 133);
          }
        }

        return GestureDetector(
          onTap: () => onSelect(answer.optionId),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: answer.type == 'image'
                ? Image.network(answer.content, fit: BoxFit.contain)
                : Text(
                    answer.content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
