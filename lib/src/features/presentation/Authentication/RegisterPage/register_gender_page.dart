import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/button_fourth_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/button_secondary_custom.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:mathgasing_v1/src/shared/Components/card_gender.dart';
import 'package:provider/provider.dart';
import 'register_provider.dart';
import 'register_user_data_page.dart';

class RegisterGenderPage extends StatelessWidget {
  const RegisterGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Judul Halaman
              const Text(
                "Jenis Kelamin\nKamu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Poppins-SemiBold',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pilihlah jenis kelamin kamu untuk\nmendaftar.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-Light',
                  color: AppColors.thirdColor,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Pilihan Gender dengan CardGender Component
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardGender(
                    gender: "Laki-laki",
                    imagePath: "assets/images/male-card.png",
                    isSelected: provider.gender == "Laki-laki",
                    onTap: () => provider.setGender("Laki-laki"), // ✅ Simpan gender saat dipilih
                  ),
                  CardGender(
                    gender: "Perempuan",
                    imagePath: "assets/images/female-card.png",
                    textAlignment: Alignment.centerRight,
                    isSelected: provider.gender == "Perempuan",
                    onTap: () => provider.setGender("Perempuan"), // ✅ Simpan gender saat dipilih
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 🔹 Tombol Lanjut
              Center(
                child: provider.gender == null
                    ? ButtonFourthCustom(
                        text: "Selanjutnya",
                        onPressed: null, // Tombol tidak bisa diklik
                      )
                    : ButtonSecondaryCustom(
                        text: "Selanjutnya",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterUserDataPage(),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
