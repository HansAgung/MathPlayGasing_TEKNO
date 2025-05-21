import 'package:flutter/material.dart';
import '../../../../../shared/Utils/app_colors.dart';

class OptionTestHeader extends StatelessWidget {
  final String title;
  final int timeRemaining;

  const OptionTestHeader({
    super.key,
    required this.title,
    required this.timeRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        const SizedBox(height: 8),
        const Text("Sisa Waktu", style: TextStyle(fontSize: 12, color: AppColors.white)),
        const SizedBox(height: 4),
        Text(
          "$timeRemaining detik",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
      ],
    );
  }
}
