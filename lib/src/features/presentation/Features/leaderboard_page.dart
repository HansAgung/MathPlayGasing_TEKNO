import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/leaderboard_model.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../data/repository/leaderboard_repository.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late Future<List<LeaderboardModel>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    _leaderboardFuture = LeaderboardRepository().fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<LeaderboardModel>>(
          future: _leaderboardFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Data leaderboard kosong."));
            }

            final leaderboard = snapshot.data!;
            final top3 = leaderboard.take(3).toList()
              ..sort((a, b) => b.points.compareTo(a.points));
            final remaining = leaderboard
                .where((e) => !top3.contains(e))
                .toList()
              ..sort((a, b) => b.points.compareTo(a.points));
            final bottom5 = remaining.take(5).toList();

            return Column(
              children: [
                // SizedBox(height: screenHeight * 0.05),
                Stack(
                  children: [ 
                    SizedBox(
                      height: screenHeight / 2.8,
                      width: double.infinity,
                      child: Image.asset(
                        AppImages.LEADERBOARD_IMG_1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const Text(
                            "Papan Peringkat",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins-SemiBold',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildUserCircle(top3.length > 1 ? top3[1] : null, 66),
                              const SizedBox(width: 30),
                              _buildUserCircle(top3.isNotEmpty ? top3[0] : null, 100),
                              const SizedBox(width: 30),
                              _buildUserCircle(top3.length > 2 ? top3[2] : null, 90),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Jadilah juara",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Kumpulkan poin sebanyak mungkin, untuk menjadi pemenang.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: bottom5.length,
                    itemBuilder: (context, index) {
                      final user = bottom5[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primaryColor,
                            child: Text(
                              "${index + 4}", // urutan dimulai dari 4
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(user.username),
                          trailing: Text(
                            "${user.points} pts",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserCircle(LeaderboardModel? user, double size) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withOpacity(0.7),
          ),
          alignment: Alignment.center,
          child: user != null
              ? Text(
                  user.username[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size / 3,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(height: 4),
        if (user != null)
          Text(
            user.username,
            style: const TextStyle(fontSize: 12),
          ),
        if (user != null)
          Text(
            "${user.points} pts",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
