import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/homepage.dart';
import 'package:mathgasing_v1/src/shared/Components/app_bar_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/bottom_navbar_custom.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestpageState();
}

class _QuestpageState extends State<QuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [AppColors.primaryColor, AppColors.thirdColor],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              color: Colors.white,
            ),
          ),

          // 🔹 Konten dengan AppBar dan Scroll
          SafeArea(
            child: Column(
              children: [
                const AppBarCustom(title: "Quest"),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 90, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // 🔹 Contoh Konten
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Halaman Quest",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins-Bold',
                              color: Color.fromARGB(255, 33, 137, 197),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // TODO: Tambahkan konten quest lain di sini
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Bottom Navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbarCustom(
              selectedIndex: 1,
              onItemTapped: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Homepage()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
