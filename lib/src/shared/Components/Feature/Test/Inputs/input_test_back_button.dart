import 'package:flutter/material.dart';
import '../../../../../shared/Utils/app_colors.dart';

class InputTestBackButton extends StatelessWidget {
  const InputTestBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
              BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.primaryColor, size: 24),
        ),
      ),
    );
  }
}
