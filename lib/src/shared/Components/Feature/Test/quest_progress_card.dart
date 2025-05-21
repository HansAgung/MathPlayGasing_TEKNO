import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

class QuestProgressCard extends StatelessWidget {
  final int idQuest;
  final String titleQuest;
  final String imageUrl;
  final double progress; // dalam range 0.0 - 1.0
  final VoidCallback? onTap;  // <-- Tambahkan parameter onTap

  const QuestProgressCard({
    super.key,
    required this.idQuest,
    required this.titleQuest,
    required this.imageUrl,
    required this.progress,
    this.onTap,  // <-- Terima onTap dalam konstruktor
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,  // <-- Trigger onTap jika ada
      child: Container(
        height: screenHeight / 6,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            opacity: 0.8, 
          ),
          boxShadow: [
            BoxShadow( 
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleQuest,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins-SemiBold',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Progress Kamu",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Light',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${(progress * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins-SemiBold',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
