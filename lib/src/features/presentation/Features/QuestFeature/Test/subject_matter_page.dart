import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/QuestFeature/reward_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../shared/Components/button_secondary_custom.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/Utils/app_colors.dart';
import '../../../../data/models/subject_matter_model.dart';
import '../../../../data/repository/subject_matter_repository.dart';

class SubjectMatterPage extends StatefulWidget {
  final int idLessonQuest;

  const SubjectMatterPage({super.key, required this.idLessonQuest});

  @override
  State<SubjectMatterPage> createState() => _SubjectMatterPageState();
}

class _SubjectMatterPageState extends State<SubjectMatterPage> {
  late Future<SubjectMatterModel> futureSubject;

  @override
  void initState() {
    super.initState();
    futureSubject =
        SubjectMatterRepository().fetchSubjectMatter(widget.idLessonQuest);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final patternHeight = screenSize.height * 0.5;
    final patternWidth = screenSize.width * 2 / 3;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: AppBar(
            title: const Text(
              "Materi Pembelajaran",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),

      body: FutureBuilder<SubjectMatterModel>(
        future: futureSubject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final subject = snapshot.data!;
            final content = subject.content;

            return Stack(
              children: [
                // 🔵 PATTERN LATAR
                Positioned(
                  top: 0,
                  left: -20,
                  child: Image.asset(
                    AppImages.PATTERN_THIRD,
                    height: patternHeight,
                    width: patternWidth,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: patternHeight / 0.9,
                  right: -20,
                  child: Image.asset(
                    AppImages.PATTERN_SECOND,
                    height: patternHeight,
                    width: patternWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                // 🔶 KONTEN DI ATAS LATAR
                ListView.builder(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  itemCount: content.length + 2,
                  itemBuilder: (context, index) {
                    final parsedDate = DateTime.parse(subject.createdAt);
                    final formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject.titleSubjectMatter,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: "Poppins-SemiBold",
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: "Poppins-Light",
                              color: AppColors.fontDescColor,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            subject.subjectMatterDesc,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins-Light",
                              color: AppColors.fontDescColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                    if (index == content.length + 1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: ButtonSecondaryCustom(
                          text: "Mulai Latihan",
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => RewardPage()),
                            );
                          }
                        ),
                      );
                    }

                    final item = content[index - 1];
                    final videoId =
                        YoutubePlayer.convertUrlToId(item.videoUrl ?? '');

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          if (videoId != null && videoId.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16), // Atur sesuai kebutuhan
                              child: YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: videoId,
                                    flags: const YoutubePlayerFlags(
                                      autoPlay: false,
                                      mute: false,
                                    ),
                                  ),
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.amber,
                                ),
                                builder: (context, player) => player,
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                          Text(
                            item.titleMaterial,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (item.materialImgSupport != null &&
                              item.materialImgSupport!.isNotEmpty) ...[
                            Image.network(item.materialImgSupport!),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 16),
                          Text(item.descriptionMaterial,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins-Light",
                              color: AppColors.fontDescColor
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    );
                  },

                  
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Gagal memuat data: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

