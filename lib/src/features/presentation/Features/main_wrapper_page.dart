import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/ProfileFeature/profile_page.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/Artefact/artefak_page.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/leaderboard_page.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/buttom_navbar_custom.dart';
import 'QuestFeature/quest_page.dart';
import 'homepage.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

class MainWrapperPage extends StatefulWidget {
  final int? initialIndex;
  const MainWrapperPage({this.initialIndex, super.key});

  @override
  _MainWrapperPageState createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  final List<Widget> _pages = [
    const Homepage(),
    const QuestPage(),
    const ArtefakPage(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];

  final List<String> _pageTitles = [
    '',
    'Misi',
    'Artefak',
    'Papan Peringkat',
    'Profil',
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          if (_currentIndex != 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                // Jika kamu ingin AppBar aktif kembali, uncomment di bawah ini
                // child: AppBar(
                //   title: Text(
                //     _pageTitles[_currentIndex],
                //     style: const TextStyle(color: Colors.white),
                //   ),
                //   backgroundColor: AppColors.primaryColor,
                //   iconTheme: const IconThemeData(color: Colors.white),
                //   elevation: 0,
                // ),
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavbarCustom(
              currentIndex: _currentIndex,
              onTap: _onBottomNavTapped,
            ),
          ),
        ],
      ),
    );
  }
}