import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/search_bar_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/quest_progress_card.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../data/models/quest_model.dart';
import '../../../data/repository/quest_repository.dart';
import 'quest_module_page.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final TextEditingController controller = TextEditingController();
  List<QuestModel> questList = [];
  bool isLoading = true;

  final List<double> greyscaleMatrix = [
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ];

  @override
  void initState() {
    super.initState();
    fetchQuests();
  }

  Future<void> fetchQuests() async {
    final data = await QuestRepository().fetchQuestList(page: 1, pageSize: 10);
    setState(() {
      questList = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                "Progress Capaianmu",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 22,
                  fontFamily: 'Poppins-SemiBold',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Temukan artefak pembelajaran yang telah kamu pelajari dan dapatkan dari petualangan mu.",
                style: TextStyle(
                  color: AppColors.fontDescColor,
                  fontSize: 12,
                  fontFamily: 'Poppins-Light',
                ),
              ),
              const SizedBox(height: 16),
              SearchBarCustom(controller: controller),
              const SizedBox(height: 16),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: questList.map(
                        (quest) {
                          final modules = quest.moduleContent?.questModule ?? [];
                          final isLocked = quest.status == "toDo";

                          Widget card = QuestProgressCard(
                            idQuest: quest.idQuest,
                            titleQuest: quest.titleQuest,
                            imageUrl: quest.imgCardQuest,
                            progress: quest.progress,
                          );

                          if (isLocked) {
                            card = ColorFiltered(
                              colorFilter: ColorFilter.matrix(greyscaleMatrix),
                              child: card,
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: isLocked
                                ? card
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => QuestModulePage(
                                            title: quest.titleQuest,
                                            questModules: modules,
                                          ),
                                        ),
                                      );
                                    },
                                    child: card,
                                  ),
                          );
                        },
                      ).toList(),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(),
    );
  }
}
