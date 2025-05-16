import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/button_third_custom.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../shared/Utils/app_colors.dart';
import '../../../../data/repository/input_question_repository.dart';
import '../../../../data/models/input_question_model.dart';

class InputTestPage extends StatefulWidget {
  const InputTestPage({super.key});

  @override
  State<InputTestPage> createState() => _InputTestPageState();
}

class _InputTestPageState extends State<InputTestPage> {
  late Future<InputTestModel> futureInputTest;
  int currentQuestionIndex = 0;
  late int remainingTime;
  Timer? _timer;
  final TextEditingController _answerController = TextEditingController();
  List<Map<String, dynamic>> inputValues = [];

  @override
  void initState() {
    super.initState();
    futureInputTest = InputTestRepository().fetchInputTest();
    futureInputTest.then((data) {
      remainingTime = data.setTime;
      // Inisialisasi inputValues = 0 untuk setiap opsi input (bukan berdasarkan option.value)
      if (data.optionImg != null) {
        inputValues = List.generate(data.optionImg!.length, (_) => {"value": 0});
      }

      startTimer();
    });
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            timer.cancel();
            _showFinishDialog();
          }
        });
      }
    });
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Kamu Hebat!"),
        content: const Text("Selamat, kamu sudah menyelesaikan kuis."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.QUESTION_BACKGROUND),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Safe Area
          SafeArea(
            child: FutureBuilder<InputTestModel>(
              future: futureInputTest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  final question = data.question[currentQuestionIndex];

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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.titleQuestion,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.fontDescColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Sisa Waktu",
                              style: TextStyle(fontSize: 12, color: AppColors.thirdColor),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "$remainingTime detik",
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.fontDescColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Question Box
                        Container(
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

                        const SizedBox(height: 24),

                        Text(
                          "Silakan jawab pertanyaan tersebut dengan memilih salah satu opsi yang tersedia di bawah ini.",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.fontDescColor,
                            fontFamily: "Poppins-Light",
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Input Answer
                        if (data.optionImg != null && data.optionImg!.isNotEmpty)
                          Column(
                            children: data.optionImg!.asMap().entries.map((entry) {
                              final index = entry.key;
                              final option = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    // Gambar atau placeholder
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[300],
                                      ),
                                      child: option.img != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Image.asset(
                                                'assets/images/${option.img}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => Container(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
                                          : Container(color: Colors.grey),
                                    ),
                                    const SizedBox(width: 16),

                                    // Kontrol input angka
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: AppColors.primaryColor),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            // Tombol minus (persegi)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (inputValues[index]["value"] > 0) {
                                                    inputValues[index]["value"]--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(12),
                                                    bottomLeft: Radius.circular(12)
                                                  ),
                                                  // jika ingin ada border internal bisa tambahkan borderRadius di sini
                                                ),
                                                child: const Icon(Icons.remove, color: Colors.white),
                                              ),
                                            ),

                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${inputValues[index]["value"]}',
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),

                                            // Tombol plus (persegi)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  inputValues[index]["value"]++;
                                                });
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(12),
                                                    bottomRight: Radius.circular(12)
                                                  ),
                                                ),
                                                child: const Icon(Icons.add, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        else
                          // Jika tidak ada opsi, tampilkan fallback TextField seperti biasa
                          TextField(
                            controller: _answerController,
                            decoration: InputDecoration(
                              hintText: 'Ketik jawabanmu di sini...',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(color: AppColors.primaryColor),
                              ),
                            ),
                          ),


                        const Spacer(),

                        // Next Button
                        SizedBox(
                          width: double.infinity,
                          child: ButtonThirdCustom(
                            text: currentQuestionIndex < data.question.length - 1
                                ? 'Selanjutnya'
                                : 'Kamu Hebat',
                            onPressed: () {
                              if (currentQuestionIndex < data.question.length - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                  _answerController.clear();
                                });
                              } else {
                                _timer?.cancel();
                                _showFinishDialog();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}