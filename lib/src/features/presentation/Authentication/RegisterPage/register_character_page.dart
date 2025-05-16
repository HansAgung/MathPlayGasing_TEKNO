import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Authentication/RegisterPage/register_provider.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/homepage.dart';
import 'package:mathgasing_v1/src/shared/Components/button_primary_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/button_fourth_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/term_checkbox.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/main_wrapper_page.dart';

class RegisterCharacterPage extends StatefulWidget {
  const RegisterCharacterPage({super.key});

  @override
  _RegisterCharacterPageState createState() => _RegisterCharacterPageState();
}

class _RegisterCharacterPageState extends State<RegisterCharacterPage> {
  int? selectedIndex; 
  bool isLoading = true;
  bool isChecked = false;
  bool isCharacterSelected = false;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _loadCharacters() async {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    await provider.loadCharacters();
    setState(() {
      isLoading = false;
    });
  }

  void _handleCharacterSelection() async {
    if (selectedIndex == null) return;

    final provider = Provider.of<RegisterProvider>(context, listen: false);
    final characters = provider.characters;
    final selectedCharacter = characters[selectedIndex!].imgPath;

    await provider.setCharacter(selectedCharacter);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("character", selectedCharacter);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainWrapperPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);
    final characters = provider.characters;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Konten utama
          Padding(
            padding: const EdgeInsets.all(20),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          const Text(
                            "Pilih Karaktermu",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Pilihlah karakter kesukaanmu!",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins-Regular',
                              color: AppColors.fontDescColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "3/3",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins-SemiBold',
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 🔹 Lingkaran untuk karakter yang dipilih
                      Container(
                        width: 270,
                        height: 270,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: selectedIndex != null
                                  ? DecorationImage(
                                      image: AssetImage(characters[selectedIndex!].imgPath),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Column(
                        children: [
                          const Text(
                            "Karakter Lainnya",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Berikut adalah daftar karakter yang dapat kamu pilih.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins-Regular',
                              color: Color.fromARGB(255, 146, 142, 142),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Box karakter (Carousel)
                      Container(
                        width: double.infinity,
                        height: 169,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 217, 215),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: characters.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  isCharacterSelected = true;
                                });
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(characters[index].imgPath),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔹 Checkbox Terms & Conditions
                      TermsCheckbox(
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // 🔹 Tombol "Selesai"
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: isCharacterSelected && isChecked
                            ? ButtonPrimaryCustom(
                                text: "Selesai",
                                onPressed: _handleCharacterSelection,
                              )
                            : ButtonFourthCustom(
                                text: "Pilih Karakter Anda",
                                onPressed: () {},
                              ),
                      ),
                    ],
                  ),
          ),

          // 🔹 Back Button di lapisan paling atas
          Positioned(
            top: 5,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
