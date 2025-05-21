import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/onboarding_model.dart';
import 'package:mathgasing_v1/src/features/data/repository/onboarding_repository.dart';
import 'package:mathgasing_v1/src/features/presentation/Authentication/login_page.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_top_bar.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_third_custom.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<OnboardingModel> _onboardingData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadData();

    // Auto-slide setiap 5 detik
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < _onboardingData.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel(); // Stop di halaman terakhir
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _loadData() async {
    final data = await OnboardingRepository.loadOnboardingData();
    setState(() {
      _onboardingData = data;
    });
  }

  void _goToNextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {  
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void _skipOnboarding() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _onboardingData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = _onboardingData[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            data.backgroundImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.black.withOpacity(0.4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // SafeArea hanya untuk tombol "Lewati"
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: _currentIndex < _onboardingData.length - 1
                          ? ButtonTopBar(
                              text: "Lewati",
                              onPressed: _skipOnboarding,
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),

                // Posisi teks agar berada di atas indikator dengan jarak 40px
                Positioned(
                  bottom: 120,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _onboardingData[_currentIndex].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _onboardingData[_currentIndex].description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Indikator halaman (rata tengah, 20px dari tombol)
                Positioned(
                  bottom: 100, // 54px (button height) + 20px (gap)
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_onboardingData.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 26 : 8, // Aktif: 26px, Non-aktif: 8px
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _currentIndex == index ? Colors.white : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
                // Tombol Berikutnya / Oke Saya Mengerti (tetap menempel di bawah)
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: ButtonThirdCustom(
                    text: _currentIndex == _onboardingData.length - 1
                        ? "Oke, Saya Mengerti"
                        : "Berikutnya",
                    onPressed: _goToNextPage,
                  ),
                ),
              ],
            ),
    );
  }
}
