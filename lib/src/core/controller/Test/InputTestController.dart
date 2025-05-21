import 'dart:async';
import 'package:flutter/material.dart';

import '../../../features/data/models/input_question_model.dart';
import '../../../features/data/repository/input_question_repository.dart';

class InputTestController {
  final VoidCallback onUpdate;
  final VoidCallback onFinish;
  final Function(String) onError;
  final InputTestRepository repository;
  late InputTestModel inputTest;
  bool isLoaded = false;
  Color? borderColor;
  int currentQuestionIndex = 0;
  List<Map<String, int>> inputValues = [];
  int remainingTime = 0;

  Timer? _timer;

  InputTestController({
    required this.onUpdate,
    required this.onFinish,
    required this.onError,
    required this.repository,
  });

  Future<void> loadData() async {
    try {
      final dataFromApi = await repository.fetchInputTest();
      inputTest = dataFromApi;

      inputValues = inputTest.optionImg.map((_) => {"value": 0}).toList();
      remainingTime = inputTest.setTime;
      isLoaded = true;

      startTimer();

      onUpdate();
    } catch (e) {
      onError("Gagal memuat data: $e");
    }
  }

  void startTimer() {
    _timer?.cancel(); // pastikan timer sebelumnya dihentikan
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        onUpdate();
      } else {
        timer.cancel();
        onFinish(); // navigasi ke RewardPage akan dipicu dari onFinish
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < inputTest.question.length - 1) {
      currentQuestionIndex++;
      resetInputValues(); 
      borderColor = null; 
      onUpdate();
    } else {
      onFinish();
    }
  }

  void resetInputValues() {
    for (int i = 0; i < inputValues.length; i++) {
      inputValues[i]["value"] = 0;
    }
  }

  void decrementValue(int index) {
    if (index < 0 || index >= inputValues.length) return;
    final currentValue = inputValues[index]["value"] ?? 0;
    if (currentValue > 0) {
      inputValues[index]["value"] = currentValue - 1;
      onUpdate();
    }
  }

  void incrementValue(int index) {
    if (index < 0 || index >= inputValues.length) return;
    final currentValue = inputValues[index]["value"] ?? 0;
    if (currentValue < 99) {
      inputValues[index]["value"] = currentValue + 1;
      onUpdate();
    }
  }

  void inputValue(int index, int value) {
    if (index < 0 || index >= inputValues.length) return;
    if (value >= 0 && value <= 99) {
      inputValues[index]["value"] = value;
      onUpdate();
    }
  }

  void checkAnswer() {
    int totalUserInput = 0;

    for (int i = 0; i < inputTest.optionImg.length; i++) {
      final inputCount = inputValues[i]["value"] ?? 0;
      final optionValue = inputTest.optionImg[i].value; // dari model
      totalUserInput += inputCount * optionValue;
    }

    if (totalUserInput == inputTest.question[currentQuestionIndex].answer) {
      borderColor = Colors.green;
    } else {
      borderColor = Colors.red;
    }

    onUpdate();
  }

  void dispose() {
    _timer?.cancel();
  }
}
