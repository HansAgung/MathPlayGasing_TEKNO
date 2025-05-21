import 'package:flutter/material.dart';
import '../../../../../shared/Utils/app_colors.dart';

class InputButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool topLeft;
  final bool bottomLeft;
  final bool topRight;
  final bool bottomRight;

  const InputButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.topLeft = false,
    this.bottomLeft = false,
    this.topRight = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: topLeft ? const Radius.circular(12) : Radius.zero,
            bottomLeft: bottomLeft ? const Radius.circular(12) : Radius.zero,
            topRight: topRight ? const Radius.circular(12) : Radius.zero,
            bottomRight: bottomRight ? const Radius.circular(12) : Radius.zero,
          ),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
