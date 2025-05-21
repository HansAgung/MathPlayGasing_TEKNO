import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/repository/option_question_repository.dart';
import '../../../features/data/models/option_question_model.dart';

class OptionTestController {
  late Future<OptionTestModel> futureOptionTest;
  List<String?> selectedAnswers = [];
  List<bool?> answerStatus = [];
  int currentIndex = 0;
  late Timer _timer;
  Duration remainingTime = Duration.zero;

  void init(VoidCallback updateUI, VoidCallback onTimeUp) {
    futureOptionTest = OptionTestRepository().fetchOptionTest();
    futureOptionTest.then((data) {
      selectedAnswers = List<String?>.filled(data.questions.length, null);
      answerStatus = List<bool?>.filled(data.questions.length, null);

      remainingTime = Duration(seconds: data.setTime);

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (remainingTime.inSeconds > 0) {
          remainingTime -= const Duration(seconds: 1);
          updateUI();
        } else {
          _timer?.cancel();
          updateUI();
          onTimeUp();
        }
      });
      updateUI(); 
    });
  }

  void submitAnswer(String selectedId) {
    selectedAnswers[currentIndex] = selectedId;

    futureOptionTest.then((data) {
      final correctId = data.answers[currentIndex].correctAnswer;
      answerStatus[currentIndex] = (selectedId == correctId);
    });
  }

  void nextQuestion(BuildContext context) {
    if (currentIndex < selectedAnswers.length - 1) {
      currentIndex++;
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Selesai!"),
          content: const Text("Kamu sudah menyelesaikan semua soal."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void dispose() {
    _timer.cancel();
  }
}
