import 'package:mathgasing_v1/src/features/data/models/quest_module_model.dart';

import 'lesson_quest_model.dart';

class QuestModel {
  final int idQuest;
  final String titleQuest;
  final String questDesc;
  final String imgCardQuest;
  final double progress; // Add this field
  final ModuleContent? moduleContent; // Add moduleContent
  final String status;

  // Constructor
  QuestModel({
    required this.idQuest,
    required this.titleQuest,
    required this.questDesc,
    required this.imgCardQuest,
    required this.progress,
    this.moduleContent, // Make moduleContent optional
    required this.status,
  });

  // Factory constructor for converting JSON data to QuestModel
  factory QuestModel.fromJson(Map<String, dynamic> json) {
    return QuestModel(
      idQuest: json['id_quest'] ?? 0, // Handle null values for idQuest
      titleQuest: json['title_quest'] ?? '', // Handle null values for titleQuest
      questDesc: json['quest_desc'] ?? '', //Handle null value quest_desc
      imgCardQuest: json['img_card_quest'] ?? '', // Handle null values for imgCardQuest
      progress: (json['progress'] != null ? json['progress'].toDouble() : 0.0), // Ensure progress is parsed to double safely
      moduleContent: json['module_content'] != null
          ? ModuleContent.fromJson(json['module_content'])
          : null, // Parse moduleContent if it's available
      status: json['status'] ?? '', // Handle null values for status
    );
  }
}

// Define the ModuleContent class, which holds questModules
class ModuleContent {
  final List<QuestModuleModel> questModule;

  ModuleContent({required this.questModule});

  factory ModuleContent.fromJson(Map<String, dynamic> json) {
    // Handle null and check if quest_module is present
    var list = json['quest_module'] as List? ?? [];
    List<QuestModuleModel> questModulesList = list.map((i) => QuestModuleModel.fromJson(i)).toList();
    return ModuleContent(questModule: questModulesList);
  }
}