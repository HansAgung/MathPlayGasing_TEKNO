import 'package:flutter/material.dart';
import '../../../../core/constants/app_images.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap; // Callback untuk navigasi

  const LessonCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: screenHeight / 10, 
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(AppImages.LESSON_IMG_1),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-SemiBold',
                  color: Color.fromARGB(255, 16, 82, 24),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins-Light',
                  color: Color.fromARGB(255, 67, 66, 66),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
