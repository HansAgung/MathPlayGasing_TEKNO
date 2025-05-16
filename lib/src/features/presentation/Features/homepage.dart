import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/Subscribes/subscribe_page.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/main_wrapper_page.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/app_images.dart';
import '../../../shared/Components/header_homepage.dart';
import '../../../shared/Components/search_bar_custom.dart';
import '../../../shared/Components/subcribe_status.dart';
import '../../data/models/quest_model.dart';
import '../../data/repository/quest_repository.dart';
import '../../../shared/Components/quest_progress_card.dart';
import 'QuestFeature/quest_module_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final QuestRepository _repo = QuestRepository();

  List<QuestModel> _quests = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _fetchQuests();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchQuests() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final quests = await _repo.fetchQuestList(page: _currentPage, pageSize: _pageSize);

      setState(() {
        _quests.addAll(quests);
        _isLoading = false;
        _currentPage++;
        if (quests.length < _pageSize) {
          _hasMore = false;
        }
      });

      // ✅ Hitung dan cetak status quest
      final int onProgressCount = _quests.where((q) => q.status == "onProgress").length;
      print("Jumlah quest dengan status onProgress: $onProgressCount");
      print("Jumlah total quest: ${_quests.length}");
    } catch (e) {
      print('❌ Error fetching quests: $e');
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      _fetchQuests();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<QuestModel> _onProgressQuests = _quests.where((quest) => quest.status == "onProgress").toList();

    final int totalQuest = _quests.length;
    final int onProgressCount = _quests.where((q) => q.status == "toDo").length;
    final double progressPercent = totalQuest > 0 ? 1 - (onProgressCount / totalQuest) : 0.0;
    final int progressPercentInt = (progressPercent * 100).round();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white),

            SizedBox(
              height: screenHeight / 2,
              width: double.infinity,
              child: Image.asset(
                AppImages.PATTERN_FIRST,
                fit: BoxFit.cover,
              ),
            ),

            // Scrollable content
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const HeaderHomepage(),
                      const SizedBox(height: 12),
                      Positioned(
                        top: 15,
                        right: -28,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: SubscribeStatus(
                            type: SubscribeType.subscribe,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SubscribePage()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pembelajaran mu",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                          Text(
                            "Ayo mulai petualanganmu!!",
                            style: TextStyle(
                              color: AppColors.fontDescColor,
                              fontSize: 12,
                              fontFamily: 'Poppins-Light',
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainWrapperPage(initialIndex: 2)),
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                            color: AppColors.fontDescColor,
                            fontSize: 10,
                            fontFamily: 'Poppins-Light',
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Progress Card
                  Container(
                    height: screenHeight / 6.5,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Progress Capaianmu",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 22,
                                  fontFamily: 'Poppins-SemiBold',
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Lanjutkan progressmu hari ini",
                                style: TextStyle(
                                  color: AppColors.fontDescColor,
                                  fontSize: 12,
                                  fontFamily: 'Poppins-Light',
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ✅ Circular Progress yang sudah dihitung
                        CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 8.0,
                          percent: progressPercent,
                          backgroundColor: Colors.grey.shade300,
                          progressColor: AppColors.primaryColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "$progressPercentInt%",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  SearchBarCustom(
                    controller: _searchController,
                    onChanged: (value) {},
                  ),

                  const SizedBox(height: 20),

                  // Quest List
                  ListView.builder(
                    itemCount: _onProgressQuests.length + (_hasMore ? 1 : 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= _onProgressQuests.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final quest = _onProgressQuests[index];
                      final modules = quest.moduleContent?.questModule ?? [];

                      return GestureDetector(
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
                        child: QuestProgressCard(
                          idQuest: quest.idQuest,
                          titleQuest: quest.titleQuest,
                          imageUrl: quest.imgCardQuest,
                          progress: quest.progress,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
