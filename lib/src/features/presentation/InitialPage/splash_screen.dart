import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/main_wrapper_page.dart';
import 'package:mathgasing_v1/src/features/presentation/InitialPage/onboarding_page.dart';
import 'package:mathgasing_v1/src/core/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    if (email != null && password != null) {
      // Sudah pernah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainWrapperPage()),
      );
    } else {
      // Belum login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: screenHeight / 2,
              width: double.infinity,
              child: Image.asset(
                AppImages.PATTERN_FIRST,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              AppImages.ICON_MATHPLAY_GASING,
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Version 1.1.0",
                  style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Develop By Team 10",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
                Text(
                  "Institut Teknologi DEL",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
