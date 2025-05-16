import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../shared/Components/button_third_custom.dart';
import '../../../../../shared/Utils/app_colors.dart';

class FlashcardPage extends StatefulWidget {
  final int idLessonQuest;
  const FlashcardPage({super.key, required this.idLessonQuest});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> with TickerProviderStateMixin {
  List<String> cardValues = ['1', '2', '1', '2'];
  List<bool> flipped = [false, false, false, false];
  List<bool> matched = [false, false, false, false];
  List<int> selectedIndices = [];
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  Timer? _timer;
  int _secondsLeft = 45;

  bool get isGameFinished => matched.every((m) => m);

  @override
  void initState() {
    super.initState();
    shuffleCards();
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
    });
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0, end: 1).animate(controller))
        .toList();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Waktu Habis!"),
        content: const Text("Coba lagi ya!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text("Ulangi"),
          ),
        ],
      ),
    );
  }

  void showWinDialog() {
    showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: screenHeight / 3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none, 
            children: [
              Positioned(
                right: 0,
                top: -130, 
                child: Image.asset(
                  AppImages.ASSET_IMAGES,
                  height: screenHeight / 3.8,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight / 3,
                decoration: const BoxDecoration(
                  color: AppColors.dark100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              // Konten utama
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garis Horizontal di Atas
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16), // sudut tumpul
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Teks "Congratulation"
                    const Text(
                      "Congratulation",
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins-SemiBold',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Deskripsi
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Light',
                        color: AppColors.fontDescColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kontainer Poin
                    Container(
                      height: 16,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "100 Point",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Tombol
                    ButtonThirdCustom(
                      text: "Main Lagi",
                      onPressed: () {
                        Navigator.of(context).pop();
                        resetGame();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }

  void shuffleCards() {
    cardValues.shuffle();
    flipped = List.generate(4, (_) => false);
    matched = List.generate(4, (_) => false);
    selectedIndices.clear();
  }

  void onCardTap(int index) {
    if (flipped[index] || matched[index] || selectedIndices.length == 2) return;

    setState(() => flipped[index] = true);
    _controllers[index].forward();
    selectedIndices.add(index);

    if (selectedIndices.length == 2) {
      Future.delayed(const Duration(milliseconds: 800), () {
        final first = selectedIndices[0];
        final second = selectedIndices[1];

        if (cardValues[first] == cardValues[second]) {
          setState(() {
            matched[first] = true;
            matched[second] = true;
          });
          if (isGameFinished) {
            Future.delayed(const Duration(milliseconds: 500), showWinDialog);
          }
        } else {
          _controllers[first].reverse();
          _controllers[second].reverse();
          setState(() {
            flipped[first] = false;
            flipped[second] = false;
          });
        }
        selectedIndices.clear();
      });
    }
  }

  void resetGame() {
    setState(() {
      _secondsLeft = 45;
      shuffleCards();
      for (var controller in _controllers) {
        controller.reset();
      }
      startTimer();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: AppBar(
            title: const Text(
              "MiniGames",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: screenHeight / 2,
              width: double.infinity,
              child: Image.asset(
                AppImages.PATTERN_FIRST,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: [
                const Text(
                  "FlashCard Games",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins-SemiBold',
                    color: AppColors.thirdColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.ARTEFAK_IMG_BG,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final animation = _animations[index];
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            final isFlipped = animation.value >= 0.5;
                            return GestureDetector(
                              onTap: () => onCardTap(index),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi * animation.value),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: matched[index] ? Colors.amber : Colors.black12,
                                      width: matched[index] ? 3 : 1,
                                    ),
                                    boxShadow: matched[index]
                                        ? [
                                            BoxShadow(
                                              color: Colors.amber.withOpacity(0.6),
                                              spreadRadius: 3,
                                              blurRadius: 6,
                                            )
                                          ]
                                        : [],
                                  ),
                                  alignment: Alignment.center,
                                  child: isFlipped
                                      ? Text(
                                          cardValues[index],
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Image.asset(
                                          AppImages.CARD_OFF,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Row(
                    children: [
                      // 🔵 Tombol Pause
                      SizedBox(
                        width: 69,
                        height: 69,
                        child: ElevatedButton(
                          onPressed: () {
                            _timer?.cancel();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.greenLight,
                            side: BorderSide(color: AppColors.greenDark, width: 2),
                          ),
                          child: Icon(
                            Icons.pause,
                            color: AppColors.greenDark,
                            size: 32,
                          ),
                        ),
                      ),

                      // 🔶 Timer countdown
                      Expanded(
                        child: Container(
                          height: 69,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors.greenLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.greenDark),
                          ),
                          child: Text(
                            '00:${_secondsLeft.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // 🔁 Tombol Refresh
                      SizedBox(
                        width: 69,
                        height: 69,
                        child: ElevatedButton(
                          onPressed: resetGame,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.greenLight,
                            side: BorderSide(color: AppColors.greenDark, width: 2),
                          ),
                          child: const Icon(
                            Icons.refresh,
                            color: AppColors.greenDark,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
