import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/Artefact/artefak_module_page.dart';
import 'package:mathgasing_v1/src/shared/Components/Feature/Artefact/artefact_progress_card.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../../shared/Components/Form/search_bar_custom.dart';
import '../../../data/models/quest_model.dart';
import '../../../data/repository/quest_repository.dart';

class ArtefakPage extends StatefulWidget {
  const ArtefakPage({super.key});

  @override
  State<ArtefakPage> createState() => _ArtefakPageState();
}

class _ArtefakPageState extends State<ArtefakPage> {
  final TextEditingController controller = TextEditingController();
  List<QuestModel> questList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuests();
  }

  Future<void> fetchQuests() async {
    final data = await QuestRepository().fetchQuestList(page: 1, pageSize: 10);
    final filtered = data.where((e) => e.status == "onProgress").toList();
    setState(() {
      questList = filtered;
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
                "Artefak Pembelajaran",
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ArtefakModulePage(
                                    title: quest.titleQuest,
                                    description: quest.questDesc,
                                    questModules: modules,
                                  ),
                                ),
                              );
                            },
                            child: ArtefactProgressCard(
                              idQuest: quest.idQuest,
                              titleQuest: quest.titleQuest,
                              descQuest: quest.questDesc ?? '',
                            ),
                          );
                        },
                      ).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
