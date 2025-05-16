import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/core/constants/app_images.dart';
import 'package:mathgasing_v1/src/shared/Components/scrolling_subscribe_type.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: AppBar(
            title: const Text(
              "Berlangganan",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Gambar dan Teks
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Area Teks (1/3 layar)
              SizedBox(
                width: screenWidth * 1 / 2.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Keuntungan Berlangganan",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontFamily: 'Poppins-SemiBold',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Keuntungan yang kamu bisa dapatkan, dengan akses premium",
                        style: TextStyle(
                          color: AppColors.fontDescColor,
                          fontSize: 10,
                          fontFamily: 'Poppins-Light',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Area Gambar (2/3 layar)
              SizedBox(
                width: screenWidth * 1.5 / 2.5,
                height: screenHeight * 0.25,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    AppImages.ASSET_SUBSCRIBE,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),

          // Container Deskripsi
          Positioned(
            top: screenHeight * 0.18,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: screenHeight * 0.30, // dipendekkan
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.dark50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pilih Paket Berlangganan",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontFamily: 'Poppins-SemiBold',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Pilih paket berlangganan yang sesuai dengan kebutuhanmu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.fontDescColor,
                        fontSize: 12,
                        fontFamily: 'Poppins-Light',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ScrollingSubscribeType di luar container, menempel ke tepi layar
          Positioned(
            top: screenHeight * 0.18 + screenHeight * 0.20 - 70,
            left: 0,
            right: 0,
            child: ScrollingSubscribeType(),
          ),
        ],
      ),
    );
  }
}
