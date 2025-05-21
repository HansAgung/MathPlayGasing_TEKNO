import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/utils/app_colors.dart';

class ButtonFourthCustom extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonFourthCustom({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Lebar selebar perangkat
      height: 54, // Tinggi 54px
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.fontDescColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Border radius 24px
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Medium',// Medium (sesuai Poppins-Medium)
            color: Colors.white, // Warna FFAE00
          ),
        ),
      ),
    );
  }
}
