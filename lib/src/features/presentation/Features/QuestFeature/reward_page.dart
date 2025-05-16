import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/core/constants/app_images.dart';
import 'package:mathgasing_v1/src/shared/Components/button_third_custom.dart';

import '../../../../shared/Components/button_secondary_custom.dart';
import '../../../../shared/Utils/app_colors.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [    
          Container(
            width: double.infinity,
            height: screenHeight,
            color: AppColors.orange200,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: -100,
                  child: Image.asset(
                    AppImages.PATTERN_SECOND,
                    width: screenHeight * 0.3,
                    height: screenHeight * 0.3,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  right: -100,
                  child: Image.asset(
                    AppImages.PATTERN_SECOND,
                    width: screenHeight * 0.3,
                    height: screenHeight * 0.3,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(
                top:screenHeight * 0.15,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
              ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Congratulation",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 28,
                    color: AppColors.fontDescColor,
                  ),
                ),
                SizedBox(height: 10),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins-Light",
                    fontSize: 12,
                    color: AppColors.fontDescColor,
                  ),
                ),
              ],
            ),
          ),
        
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: screenHeight * 0.58,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                      color: AppColors.orange600,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.15),  
                          child: Column(
                            children: [
                              const Text(
                                "Title Badge",
                                style: TextStyle(
                                  fontSize: 28, 
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              
                              Padding(padding: EdgeInsets.all(0),
                              child: 
                                const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, fontFamily: "Poppins-Light", color: AppColors.white),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildBlueBox("1000"),
                                  SizedBox(height: 10),
                                  _buildBlueBox("100"),
                                ],
                              ),
                              const SizedBox(height: 60),
                              ButtonSecondaryCustom(
                                text: "Ambil Hadiah", 
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppImages.BADGE_IMAGES,
                      width: screenHeight * 0.35,
                      height: screenHeight * 0.25,
                    ),
                  ),
                ],
              ),
          
            ],
          ),


        ],
      ),  
    );
  }
}

Widget _buildBlueBox(String value) {
    return Container(
      width: 150,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
      
      
      
     