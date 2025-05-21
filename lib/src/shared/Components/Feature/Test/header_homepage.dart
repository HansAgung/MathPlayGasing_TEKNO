import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Subscription/redeem_points.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_images.dart';

class HeaderHomepage extends StatefulWidget {
  const HeaderHomepage({super.key});

  @override
  State<HeaderHomepage> createState() => _HeaderHomepageState();
}

class _HeaderHomepageState extends State<HeaderHomepage> {
  String username = '';
  int points = 0;
  int energy = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
      points = prefs.getInt('points') ?? 0;
      energy = prefs.getInt('energy') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final String currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

    return Container(
      height: screenHeight / 5.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.HOMEPAGE_CARD),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome,",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              currentDate,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                _buildBlueBox(points.toString(), AppImages.POINT_ICON, "Points"),
                const SizedBox(width: 10),
                
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildBlueBox(energy.toString(), AppImages.ENERGY_ICON, "Energy"),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          BoxMessage.show(
                            context,
                            iconPath: AppImages.POINT_ICON,
                            value: points.toString(),
                            label: 'Points',
                            onSuccess: () {
                              setState(() {
                                _loadUserData();
                              });
                            },
                          );

                        },
                        child: Container(
                          width: 20,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(2),
                              topLeft: Radius.circular(2),
                              bottomRight: Radius.circular(6),
                              topRight: Radius.circular(6)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),


                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBlueBox(String value, String iconPath, String label) {
    return Container(
      width: 115,
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
            iconPath,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.fontDescColor,
              fontFamily: 'Poppins-SemiBold',
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.fontDescColor,
              fontFamily: 'Poppins-Light',
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
