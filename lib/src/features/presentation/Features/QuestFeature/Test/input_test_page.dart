import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_third_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Test/Inputs/input_test_dialog.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/controller/Test/InputTestController.dart';
import '../../../../../shared/Components/Feature/Test/Inputs/input_test_back_button.dart';
import '../../../../../shared/Components/Feature/Test/Inputs/input_test_header.dart';
import '../../../../../shared/Components/Feature/Test/Inputs/input_test_input_controls.dart';
import '../../../../../shared/Utils/app_colors.dart';
import '../../../../data/repository/input_question_repository.dart';
import '../reward_page.dart';


class InputTestPage extends StatefulWidget {
  const InputTestPage({super.key});

  @override
  State<InputTestPage> createState() => _InputTestPageState();
}

class _InputTestPageState extends State<InputTestPage> {
  late InputTestController controller;
  bool isLoading = true;
  final TextEditingController answerController = TextEditingController();
  final repository = InputTestRepository();

  @override
  void initState() {
    super.initState();
    controller = InputTestController(
      onUpdate: () {
        setState(() {
          answerController.text = '';
          isLoading = false;
        });
      },
      onFinish: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RewardPage()),
        );
      },
      
      onError: (msg) {
        setState(() {
          isLoading = false;
        });
        showErrorDialog(context, msg);
      },
      repository: repository,
    );

    controller.loadData();
  }

  @override
  void dispose() {
    controller.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || !controller.isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = controller.inputTest;
    final question = controller.inputTest.question[controller.currentQuestionIndex];  // <-- ambil pertanyaan aktif

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Column(
                children: [
                  const InputTestBackButton(),
                  InputTestHeader(controller: controller),
                  const SizedBox(height: 14),
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FAFA),
                      border: Border.all(
                        color: controller.borderColor ?? AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: question.type == 'image'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              question.content,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Center(
                            child: Text(
                              question.content,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.fontDescColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Silakan jawab pertanyaan tersebut dengan memilih salah satu opsi yang tersedia di bawah ini.",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white,
                      fontFamily: "Poppins-Light",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FAFA),
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(controller.inputTest.optionImg.length, (index) {
                        final option = controller.inputTest.optionImg[index];
                        final value = controller.inputValues[index]["value"] ?? 0;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            option.img != null
                                ? Image.network(
                                    option.img!,
                                    width: 20,
                                    height: 20,
                                    errorBuilder: (_, __, ___) => Container(width: 32, height: 32, color: Colors.grey),
                                  )
                                : Container(width: 32, height: 32, color: Colors.grey),
                            const SizedBox(height: 4),
                            Text(option.value.toString(), style: const TextStyle(fontSize: 16)),
                          ],
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 12),
                  InputTestInputControls(controller: controller, answerController: answerController),
                  const Spacer(),
                  ButtonThirdCustom(
                    text: controller.currentQuestionIndex == (controller.inputTest.question.length - 1)
                        ? "Kamu Hebat"
                        : "Selanjutnya",
                    onPressed: () {
                      controller.checkAnswer(); 
                      Future.delayed(const Duration(seconds: 1), () {
                        controller.nextQuestion();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
