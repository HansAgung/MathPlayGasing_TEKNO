import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../features/data/models/flashcard_model.dart';
import '../../../features/data/repository/flashcard_repository.dart';
import '../../../shared/Components/Feature/Test/Flashcard/box_message_winDialog.dart';
import '../../constants/app_images.dart';

class FlashcardController with ChangeNotifier {
  final FlashcardRepository _repository = FlashcardRepository();

  List<CardItem> cards = [];
  List<bool> flipped = [];
  List<bool> matched = [];
  List<int> selectedIndices = [];

  int patternCount = 0;
  int matchCount = 0;
  bool _isGameFinished = false;
  bool _isLoading = false;

  bool get isGameFinished => _isGameFinished;
  bool get isLoading => _isLoading;

  // ⏱️ Timer-related
  Timer? _timer;
  int secondsPassed = 0;

  Future<void> initializeGame(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final model = await _repository.fetchFlashcardTest();

      patternCount = model.patternCount;
      matchCount = model.matchCount;

      final totalGrid = patternCount * patternCount;
      final availableUniqueCards = model.cards;
      final neededUniqueCount = totalGrid ~/ matchCount;

      List<CardItem> selectedUniqueCards = [];
      for (int i = 0; i < neededUniqueCount; i++) {
        selectedUniqueCards.add(availableUniqueCards[i % availableUniqueCards.length]);
      }

      List<CardItem> tempCards = [];
      for (final card in selectedUniqueCards) {
        for (int i = 0; i < matchCount; i++) {
          tempCards.add(card);
        }
      }

      while (tempCards.length < totalGrid) {
        tempCards.add(selectedUniqueCards[Random().nextInt(selectedUniqueCards.length)]);
      }

      if (tempCards.length > totalGrid) {
        tempCards = tempCards.sublist(0, totalGrid);
      }

      tempCards.shuffle();

      cards = tempCards;
      flipped = List.generate(cards.length, (_) => false);
      matched = List.generate(cards.length, (_) => false);
      selectedIndices.clear();
      _isGameFinished = false;

      // 🔁 Reset & Start timer
      resetTimer();
      startTimer();
    } catch (e) {
      print('Error loading flashcard data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void onCardTap(int index, BuildContext context) {
    if (flipped[index] || matched[index] || selectedIndices.length == 2 || _isGameFinished) return;

    flipped[index] = true;
    selectedIndices.add(index);
    notifyListeners();

    if (selectedIndices.length == 2) {
      Future.delayed(const Duration(milliseconds: 800), () {
        final first = selectedIndices[0];
        final second = selectedIndices[1];

        if (cards[first].id == cards[second].id && first != second) {
          matched[first] = true;
          matched[second] = true;

          if (matched.every((m) => m)) {
            _isGameFinished = true;
            pauseTimer();
            Future.delayed(const Duration(milliseconds: 300), () {
              showWinDialog(context);
            });
          }
        } else {
          flipped[first] = false;
          flipped[second] = false;
        }

        selectedIndices.clear();
        notifyListeners();
      });
    }
  }

  void resetGame() {
    cards.shuffle();
    flipped = List.generate(cards.length, (_) => false);
    matched = List.generate(cards.length, (_) => false);
    selectedIndices.clear();
    _isGameFinished = false;
    resetTimer();
    startTimer();
    notifyListeners();
  }

  void showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BoxMessageWinDialog(
        title: "Congratulation",
        description: "Kamu telah menyelesaikan permainan dengan baik!",
        pointLabel: "100 Point",
        imagePath: AppImages.ASSET_IMAGES,
        onPressed: () {
          Navigator.of(context).pop();
          resetGame();
        },
      ),
    );
  }

  // ⏱️ Timer Functions
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      secondsPassed++;
      notifyListeners();
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    secondsPassed = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
