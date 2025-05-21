import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/QuestFeature/reward_page.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_third_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Test/Options/answer_grid.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Test/Options/option_test_header.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Test/Options/question_box.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/controller/Test/OptionQuestController.dart';
import '../../../../../shared/Utils/app_colors.dart';
import '../../../../data/models/option_question_model.dart';

class OptionTestPage extends StatefulWidget {
  const OptionTestPage({super.key});

  @override
  State<OptionTestPage> createState() => _OptionTestPageState();
}

class _OptionTestPageState extends State<OptionTestPage> {
  final controller = OptionTestController();
  bool showAnswerResult = false;

  @override
  void initState() {
    super.initState();
    controller.init(() {
      setState(() {});
    }, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RewardPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.QUESTION_BACKGROUND),
                fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), 
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: FutureBuilder<OptionTestModel>(
              future: controller.futureOptionTest,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('Tidak ada data'));
                }

                final data = snapshot.data!;
                final question = data.questions[controller.currentIndex];
                final answer = data.answers[controller.currentIndex];
                final selectedAnswer = controller.selectedAnswers[controller.currentIndex];
                final answerStatus = controller.answerStatus[controller.currentIndex];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OptionTestHeader(
                        title: data.titleQuestion,
                        timeRemaining: controller.remainingTime.inSeconds,
                      ),
                      const SizedBox(height: 24),
                      QuestionBox(question: question, screenHeight: screenHeight),
                      const SizedBox(height: 24),
                      Text(
                        question.questDesc,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: screenHeight * 0.35,
                        child: AnswerGrid(
                          answers: answer.options,
                          showAnswerResult: showAnswerResult,
                          selectedAnswer: selectedAnswer,
                          correctAnswer: answer.correctAnswer,
                          onSelect: (optId) {
                            setState(() {
                              controller.submitAnswer(optId);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonThirdCustom(
                          text: controller.currentIndex < data.questions.length - 1
                              ? 'Selanjutnya'
                              : 'Kamu Hebat',
                          onPressed: selectedAnswer != null
                              ? () {
                                  setState(() {
                                    showAnswerResult = true;
                                  });

                                  Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                      showAnswerResult = false;
                                      controller.nextQuestion(context);
                                    });
                                  });
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
