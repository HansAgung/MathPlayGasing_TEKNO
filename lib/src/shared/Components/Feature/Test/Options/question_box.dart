import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/option_question_model.dart';
import '../../../../../shared/Utils/app_colors.dart';

class QuestionBox extends StatelessWidget {
  final QuestionModel question;
  final double screenHeight;

  const QuestionBox({
    super.key,
    required this.question,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 8,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FAFA),
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(32),
      ),
      child: question.type == 'image'
          ? ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(question.content, fit: BoxFit.contain),
            )
          : Center(
              child: Text(
                question.content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.fontDescColor),
              ),
            ),
    );
  }
}
