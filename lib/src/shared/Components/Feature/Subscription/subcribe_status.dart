import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

enum SubscribeType { subscribe, silver, gold, platinum }

class SubscribeStatus extends StatefulWidget {
  final SubscribeType type;
  final VoidCallback onPressed;

  const SubscribeStatus({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  State<SubscribeStatus> createState() => _SubscribeStatusState();
}

class _SubscribeStatusState extends State<SubscribeStatus> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // Warna latar belakang berdasarkan tipe
  Color get backgroundColor {
    switch (widget.type) {
      case SubscribeType.subscribe:
        return AppColors.primaryColor;
      case SubscribeType.silver:
        return const Color(0xFFBAC0B4);
      case SubscribeType.gold:
        return const Color(0xFFFDD832);
      case SubscribeType.platinum:
        return const Color(0xFFD3E0EF);
    }
  }

  // Warna bayangan berdasarkan tipe
  Color get shadowColor {
    switch (widget.type) {
      case SubscribeType.subscribe:
      case SubscribeType.silver:
        return const Color(0xFF848582);
      case SubscribeType.gold:
        return const Color(0xFFB29929);
      case SubscribeType.platinum:
        return const Color(0xFF8FBAEB);
    }
  }

  // Teks berdasarkan tipe
  String get buttonText {
    switch (widget.type) {
      case SubscribeType.subscribe:
        return 'Subscribe Now';
      case SubscribeType.silver:
        return 'Silver';
      case SubscribeType.gold:
        return 'Gold';
      case SubscribeType.platinum:
        return 'Platinum';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(-0.05, 0), // gerak ke kiri
      end: const Offset(0.05, 0),    // gerak ke kanan
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: screenWidth / 3,
        height: 54,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(6, 0), 
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.white,
              width: 1,
            ),
          ),
          child: Center(
            child: SlideTransition(
              position: _animation,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
