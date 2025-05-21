import 'package:flutter/material.dart';
import '../../../../../core/controller/Test/InputTestController.dart';
import '../../../../../shared/Utils/app_colors.dart';
import 'input_button_widget.dart';

class InputTestInputControls extends StatelessWidget {
  final InputTestController controller;
  final TextEditingController answerController;

  const InputTestInputControls({
    super.key,
    required this.controller,
    required this.answerController,
  });

  @override
  Widget build(BuildContext context) {
    final data = controller.inputTest;

    if (data.optionImg != null && data.optionImg!.isNotEmpty) {
      return Column(
        children: data.optionImg!.asMap().entries.map((entry) {
          final i = entry.key;
          final option = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: option.img != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            option.img ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: Colors.grey),
                          ),           
                        )
                      : Container(color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        InputButton(
                          icon: Icons.remove,
                          onTap: () => controller.decrementValue(i),
                          topLeft: true,
                          bottomLeft: true,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${controller.inputValues[i]["value"]}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        InputButton(
                          icon: Icons.add,
                          onTap: () => controller.incrementValue(i),
                          topRight: true,
                          bottomRight: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return TextField(
        controller: answerController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Masukkan jawaban kamu',
        ),
      );
    }
  }
}
