import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../Button/button_primary_custom.dart';
import '../../Button/button_secondary_custom.dart';

class ScrollingSubscribeType extends StatefulWidget {
  const ScrollingSubscribeType({super.key});

  @override
  State<ScrollingSubscribeType> createState() => _ScrollingSubscribeTypeState();
}

class _ScrollingSubscribeTypeState extends State<ScrollingSubscribeType> {
  late final PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _packages = [
    {
      'title': 'Paket Perunggu',
      'image': AppImages.BADGE_SILVER,
      'benefits': [
        'Akses materi dasar',
        'Latihan soal mingguan',
      ],
      'price': 'Rp. 16.000 / Bulan',
    },
    {
      'title': 'Paket Emas',
      'image': AppImages.BADGE_GOLD,
      'benefits': [
        'Akses materi dasar',
        'Latihan soal mingguan',
        'Akses ke semua materi selama 1 Tahun',
      ],
      'price': 'Rp. 150.000 / Tahun',
    },
    {
      'title': 'Paket Platinum',
      'image': AppImages.BADGE_PLATINUM,
      'benefits': [
        'Akses materi dasar',
        'Latihan soal mingguan',
        'Akses ke semua materi selama 2 Tahun',
      ],
      'price': 'Rp. 280.000 / 2 Tahun',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildCard(Map<String, dynamic> data, double height, double width, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double scale = 1.0;
        if (_pageController.position.haveDimensions) {
          scale = (_pageController.page! - index).abs();
          scale = 1 - (scale * 0.1).clamp(0.0, 0.1);
        }
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        height: height,
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greenLight,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  data['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontFamily: 'Poppins-SemiBold',
                  ),
                ),
                const SizedBox(height: 12),
                Image.asset(
                  data['image'],
                  height: 80,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data['benefits'].length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("– ", style: TextStyle(color: Colors.black, fontSize: 14)), // Simbol bullet lebih elegan
                            Expanded(
                              child: Text(
                                data['benefits'][i],
                                style: const TextStyle(
                                  color: AppColors.fontDescColor,
                                  fontSize: 10,
                                  fontFamily: 'Poppins-SemiBold',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Mulai dari",
                  style: TextStyle(
                    color: AppColors.fontDescColor,
                    fontSize: 12,
                    fontFamily: 'Poppins-Light',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data['price'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins-SemiBold',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ButtonPrimaryCustom(
              text: 'Beli Sekarang', 
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return BoxMessage(data['price']);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 12,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardHeight = screenHeight * 0.53;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _packages.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildCard(
                _packages[index],
                cardHeight,
                screenWidth * 0.8,
                index,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_packages.length, _buildIndicator),
        ),
      ],
    );
  }
}

class BoxMessage extends StatelessWidget {
  final String price;
  const BoxMessage(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: screenHeight * 1.2 / 3, 
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16), 
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * (2 / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins-SemiBold',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Apa kamu yakin akan melakukan pembelian sebesar :",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins-SemiLight',
                    color: AppColors.fontDescColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),
          Text(
            '$price',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontSize: 8,
                  fontFamily: 'Poppins-SemiLight',
                  color: AppColors.fontDescColor,
                ),
              ),
              Image.asset(
                AppImages.QRIS_BADGE,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 2),
          ButtonSecondaryCustom(
            text: "Lanjutkan Pembayaran", 
            onPressed: (){}
          ),
        ],
      ),
    );
  }
}
