import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/quest_module_model.dart';
import '../../../../core/helper/lesson_helper.dart';
import '../../../../shared/Components/lesson_card.dart';
import '../../../../shared/Components/lesson_subject_card.dart';
import '../../../../shared/Components/search_bar_custom.dart';
import '../../../../shared/Utils/app_colors.dart';

class ArtefakModulePage extends StatefulWidget {
  final String title;
  final String description;
  final List<QuestModuleModel> questModules;

  const ArtefakModulePage({
    super.key,
    required this.title,
    required this.description,
    required this.questModules,
  });

  @override
  State<ArtefakModulePage> createState() => _ArtefakModulePageState();
}

class _ArtefakModulePageState extends State<ArtefakModulePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height / 6;

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
              "Modul Pembelajaran",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),

      backgroundColor: const Color(0xFFFFF7E6),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 22,
                fontFamily: 'Poppins-SemiBold',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                color: AppColors.fontDescColor,
                fontSize: 12,
                fontFamily: 'Poppins-Light',
              ),
            ),
            const SizedBox(height: 16),
            SearchBarCustom(controller: controller),
            const SizedBox(height: 16),

            // Menampilkan list card modul dengan dropdown
            ...widget.questModules.map(
              (module) => ExpandableModuleCard(
                module: module,
                cardHeight: cardHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableModuleCard extends StatefulWidget {
  final QuestModuleModel module;
  final double cardHeight;

  const ExpandableModuleCard({
    super.key,
    required this.module,
    required this.cardHeight,
  });

  @override
  State<ExpandableModuleCard> createState() => _ExpandableModuleCardState();
}

class _ExpandableModuleCardState extends State<ExpandableModuleCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final filteredLessons =
        filterLessonByType(widget.module.lessonQuest ?? [], 2);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Card
          Container(
            height: widget.cardHeight * 2 / 3,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2EC4B6),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.module.titleQuestModule,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Poppins-SemiBold',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.module.questModuleDesc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Poppins-Light',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Footer dengan tombol dropdown
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              height: widget.cardHeight * 1 / 3,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1B9B8F),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Lihat Item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // Dropdown Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: filteredLessons.isNotEmpty
                  ? SizedBox(
                      height: 180,
                      child: ListView.separated(
                        itemCount: filteredLessons.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final lesson = filteredLessons[index];
                          return LessonSubjectCard(
                            title: lesson.titleLessonQuest,
                            description: lesson.questLessonDesc,
                          );
                        },
                      ),
                    )
                  : const Text(
                      "Kamu belum menyelesaikan apapun.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontFamily: 'Poppins-Light',
                      ),
                    ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
