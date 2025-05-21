import 'package:flutter/material.dart';
import '../../../../../shared/Utils/app_colors.dart';
import '../../../Button/button_third_custom.dart';

class BoxMessageWinDialog extends StatelessWidget {
  final String title;
  final String description;
  final String pointLabel;
  final String imagePath;
  final VoidCallback onPressed;

  const BoxMessageWinDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.pointLabel,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Gambar dekoratif
              Positioned(
                right: 0,
                top: -130,
                child: Image.asset(
                  imagePath,
                  height: screenHeight / 3.8,
                  fit: BoxFit.contain,
                ),
              ),
              // Background utama
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
              // Konten dialog
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garis atas
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins-SemiBold',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Light',
                        color: AppColors.fontDescColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 16,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pointLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ButtonThirdCustom(
                      text: "Main Lagi",
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
