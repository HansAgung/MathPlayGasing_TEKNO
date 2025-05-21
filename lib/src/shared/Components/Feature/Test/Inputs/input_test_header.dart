import 'package:flutter/material.dart';
import '../../../../../core/controller/Test/InputTestController.dart';
import '../../../../../shared/Utils/app_colors.dart';

class InputTestHeader extends StatelessWidget {
  final InputTestController controller;

  const InputTestHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final data = controller.inputTest;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          data.titleQuestion,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Sisa Waktu",
          style: TextStyle(fontSize: 10, color: AppColors.white),
        ),
        const SizedBox(height: 4),
        Text(
          "${controller.remainingTime} detik",
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
