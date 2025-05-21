import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/controller/Test/FlashCardController.dart';
import '../../../../../shared/Components/Feature/Test/Flashcard/flashcard_grid.dart';
import '../../../../../shared/Utils/app_colors.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({Key? key}) : super(key: key);

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  late FlashcardController controller;

  @override
  void initState() {
    super.initState();
    controller = FlashcardController();
    controller.initializeGame(context); 
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FlashcardController>.value(
      value: controller,
      
      child: Scaffold(
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: AppBar(
            title: const Text(
              "Modul Pembelajaran",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),

        body: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.QUESTION_BACKGROUND),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), 
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
               const Text(
                  "FlashCard Games",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins-SemiBold',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
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
                ),
                
              const SizedBox(height: 16),
              Expanded(child: FlashcardGrid()),
              const SizedBox(height: 16),
              Consumer<FlashcardController>(
                builder: (_, controller, __) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Row(
                    children: [
                      // 🔵 Pause Button
                      SizedBox(
                        width: 69,
                        height: 69,
                        child: ElevatedButton(
                          onPressed: controller.pauseTimer,
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

                      // ⏱️ Timer Counter
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
                            '00:${controller.secondsPassed.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // 🔁 Reset Button
                      SizedBox(
                        width: 69,
                        height: 69,
                        child: ElevatedButton(
                          onPressed: controller.resetGame,
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
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}