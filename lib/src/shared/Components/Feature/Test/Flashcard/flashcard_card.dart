import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/core/constants/app_images.dart';

class FlashcardCard extends StatelessWidget {
  final bool isFlipped;
  final bool isMatched;
  final VoidCallback onTap;
  final String imageUrl;

  const FlashcardCard({
    Key? key,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMatched ? Colors.amber : Colors.black12,
            width: isMatched ? 3 : 1,
          ),
          boxShadow: isMatched
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 6,
                  )
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: isFlipped
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isMatched ? Colors.amber : Colors.black12,
                    width: isMatched ? 3 : 1,
                  ),
                ),
                child: Image.network(imageUrl,
                  fit: BoxFit.fill,
                ),
            )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isMatched ? Colors.amber : Colors.black12,
                    width: isMatched ? 3 : 1,
                  ),
                ),
                child: Image.asset(
                  AppImages.CARD_OFF,
                  fit: BoxFit.fill,
                ),
            )
      ),
    );
  }
}
