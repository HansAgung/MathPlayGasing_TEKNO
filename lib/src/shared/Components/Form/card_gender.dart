import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

class CardGender extends StatelessWidget {
  final String gender;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final Alignment textAlignment;

  const CardGender({
    super.key,
    required this.gender,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    this.textAlignment = Alignment.centerLeft, // Default teks di kiri
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Card(
        elevation: isSelected ? 6 : 2, // Efek bayangan saat dipilih
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 195,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: textAlignment,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                gender,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins-SemiBold',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
