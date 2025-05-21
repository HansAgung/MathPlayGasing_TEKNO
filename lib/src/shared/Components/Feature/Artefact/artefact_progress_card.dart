import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/quest_model.dart';
import '../../../../core/constants/app_images.dart';

class ArtefactProgressCard extends StatelessWidget {
  final int idQuest;
  final String titleQuest;
  final String descQuest;
  final VoidCallback? onTap;

  const ArtefactProgressCard({
    super.key,
    required this.idQuest,
    required this.titleQuest,
    required this.descQuest,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight / 6,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(AppImages.ARTEFAK_IMG_BG),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Center all children horizontally
          children: [
            Text(
              titleQuest,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins-SemiBold',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
             SizedBox(
              width: MediaQuery.of(context).size.width / 2, // Setengah lebar layar
              child: Text(
                descQuest,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins-Light',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
