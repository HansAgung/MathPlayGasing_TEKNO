import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Authentication/login_page.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? fullName;
  String? username;
  String? email;
  String? birthDate;
  int? points;
  int? energy;
  String? statusSubscribe;
  String? selectedCharacter;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? '';
      username = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      birthDate = prefs.getString('birthDate') ?? '';
      points = prefs.getInt('points') ?? 0;
      energy = prefs.getInt('energy') ?? 0;
      statusSubscribe = prefs.getString('status_subscribe') ?? '';
      selectedCharacter = prefs.getString('character') ?? '';
    });
  }

  Future<void> _logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Arahkan kembali ke halaman login
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SizedBox(
            height: screenHeight + 150,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: screenHeight / 3.5,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.PROFILE_IMG_BG,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: screenHeight / 3.8 - 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? 'USERNAME',
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamily: 'Poppins-SemiBold',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            email ?? 'email@example.com',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Light',
                              color: AppColors.fontDescColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                              width: 100,  
                              height: 24,
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: AppColors.green100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppImages.POINT_ICON,
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${points ?? 0}',
                                    style: const TextStyle(
                                      color: AppColors.fontDescColor,
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Points",
                                    style: const TextStyle(
                                      color: AppColors.fontDescColor,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 12),
                          const Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-SemiBold',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 107,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE3A6),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Nama Lengkap : ${fullName ?? "-"}',
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tanggal Lahir : ${birthDate ?? "-"}',
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Status Langganan : ${statusSubscribe ?? "-"}',
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Lencana",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-SemiBold',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const Text(
                            "Temukan lencana yang telah kamu kumpulkan dalam perjalananmu",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins-Light',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            color: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(3, (index) {
                                  return Container(
                                    width: 110,
                                    height: 108,
                                    margin: const EdgeInsets.only(left: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Item ${index + 1}',
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                              child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: _logoutUser,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text('Log Out', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight / 3.5 - 95,
                  right: -24,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.8),
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: selectedCharacter != null
                          ? ClipOval(
                              child: Image.asset(
                                selectedCharacter!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.person, size: 80, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Edit avatar
                          },
                          child: Container(
                            width: 63,
                            height: 63,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
