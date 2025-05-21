import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_primary_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_secondary_custom.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pastikan UserRepository sudah ditambahkan dengan fungsi updatePointsEnergy
import '../../../../features/data/repository/user_database_repository.dart';

class BoxMessage {
  static void show(
    BuildContext context, {
    required String iconPath,
    required String value,
    required String label,
    required VoidCallback onSuccess,
  }) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    final TextEditingController pointController = TextEditingController();
    final ValueNotifier<bool> isError = ValueNotifier(false);
    final ValueNotifier<int> energyResult = ValueNotifier(0);
    final ValueNotifier<bool> hasInput = ValueNotifier(false);

    // Fungsi untuk validasi input dan update energy
    void validateInput(String input) {
      if (input.isEmpty) {
        isError.value = false;
        energyResult.value = 0;
        hasInput.value = false;
        return;
      }
      hasInput.value = true;
      final int? val = int.tryParse(input);
      if (val == null || val <= 0) {
        isError.value = true;
        energyResult.value = 0;
        return;
      }
      final int maxPoint = int.tryParse(value) ?? 0;
      if (val > maxPoint) {
        isError.value = true;
        energyResult.value = 0;
      } else {
        isError.value = false;
        energyResult.value = val ~/ 4; // 4 poin = 1 energy
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: screenHeight * 1.2 / 3,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis indikator di atas
              Center(
                child: Container(
                  width: screenWidth * 0.35,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Konten pesan dengan Row
              SizedBox(
                width: screenWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Tukarkan Poin mu!!",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins-SemiBold',
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Poin yang kamu miliki saat ini adalah:",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins-SemiLight',
                              color: AppColors.fontDescColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppColors.green100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              iconPath,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: AppColors.fontDescColor,
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                label,
                                style: const TextStyle(
                                  color: AppColors.fontDescColor,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Input poin & hasil konversi energy
              ValueListenableBuilder<bool>(
                valueListenable: isError,
                builder: (context, error, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: pointController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Masukkan poin",
                                filled: true,
                                fillColor: AppColors.green100,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                              ),
                              onChanged: validateInput,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward,
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ValueListenableBuilder<int>(
                              valueListenable: energyResult,
                              builder: (context, energy, _) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.green100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "$energy Energy",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins-SemiBold',
                                      color: AppColors.fontDescColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      if (error)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Input poin tidak valid atau melebihi poin yang kamu miliki.",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),
              const Text(
                "Dengan menukarkan poin kamu bisa terus berlatih.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins-SemiLight',
                  color: AppColors.fontDescColor,
                ),
              ),
              const SizedBox(height: 16),

              // Tombol primary/secondary bergantung inputan
              ValueListenableBuilder<bool>(
                valueListenable: hasInput,
                builder: (context, hasText, _) {
                  if (!hasText) {
                    return ButtonPrimaryCustom(
                      text: "Tukar Point",
                      onPressed: () {
                        // default tanpa input, disable atau berikan alert?
                      },
                    );
                  } else {
                    return ButtonSecondaryCustom(
                      text: "Konversi Sekarang",
                      onPressed: () async {
                        final int? input = int.tryParse(pointController.text);
                        if (input == null || input <= 0) {
                          // Alert merah input salah
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[300],
                              title: const Text("Error", style: TextStyle(color: Colors.white)),
                              content: const Text("Masukkan poin yang valid.", style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        final int maxPoint = int.tryParse(value) ?? 0;
                        if (input > maxPoint) {
                          // Alert merah poin melebihi
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[300],
                              title: const Text("Gagal", style: TextStyle(color: Colors.white)),
                              content: const Text("Poin yang dimasukkan melebihi poin yang kamu miliki.", style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        // Hitung energy
                        final int energy = input ~/ 4;
                        if (energy <= 0) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[300],
                              title: const Text("Gagal", style: TextStyle(color: Colors.white)),
                              content: const Text("Poin yang dimasukkan tidak cukup untuk konversi energy.", style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        final repo = UserRepository();
                        int inputPoin = int.tryParse(pointController.text) ?? 0;
                        final success = await repo.updatePointsEnergy(inputPoin);

                        if (success) {
                          Navigator.pop(context); 
                          onSuccess();
                        } else {
                          // Gagal update data
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[300],
                              title: const Text("Gagal", style: TextStyle(color: Colors.white)),
                              content: const Text("Terjadi kesalahan saat memperbarui data.", style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
