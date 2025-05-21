import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../core/controller/Test/FlashCardController.dart';
import '../../../../../core/constants/app_images.dart';

class FlashcardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardController>(
      builder: (context, controller, _) {
        if (controller.patternCount <= 0 || controller.cards.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.patternCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.cards.length,
          itemBuilder: (context, index) {
            final card = controller.cards[index];
            final isFlipped = controller.flipped[index];
            final isMatched = controller.matched[index];

            return GestureDetector(
              onTap: () {
                controller.onCardTap(index, context);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (context, child) {
                      final isUnder = (child?.key != ValueKey(isFlipped || isMatched));
                      var tilt = isUnder ? min(rotate.value, pi / 2) : rotate.value;
                      return Transform(
                        transform: Matrix4.rotationY(tilt),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  );
                },
                layoutBuilder: (currentChild, previousChildren) =>
                    Stack(children: [if (currentChild != null) currentChild]),
                child: isFlipped || isMatched
                    ? Container(
                        key: const ValueKey(true),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(card.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        key: const ValueKey(false),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.white,
                          image: const DecorationImage(
                            image: AssetImage(AppImages.CARD_OFF),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
