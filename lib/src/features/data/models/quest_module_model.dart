import 'lesson_quest_model.dart';

class QuestModuleModel {
  final int idQuestModule;
  final String titleQuestModule;
  final String questModuleDesc;
  final int moduleStatus;
  final LessonQuestModel? lessonContent;
  final List<LessonQuestModel>? lessonQuest;
  final String status;

  QuestModuleModel({
    required this.idQuestModule,
    required this.titleQuestModule,
    required this.questModuleDesc,
    required this.moduleStatus,
    this.lessonContent,
    this.lessonQuest,
    required this.status,
  });

  factory QuestModuleModel.fromJson(Map<String, dynamic> json) {
    final lessonContentJson = json['lesson_content'];
    final lessonQuestJson = lessonContentJson?['lesson_quest'];

    return QuestModuleModel(
      idQuestModule: int.tryParse(json['id_quest_module'].toString()) ?? 0,
      titleQuestModule: json['title_quest_module']?.toString() ?? '',
      questModuleDesc: json['quest_module_desc']?.toString() ?? '',
      moduleStatus: int.tryParse(json['module_status'].toString()) ?? 0,
      lessonContent: lessonContentJson != null
          ? LessonQuestModel.fromJson(lessonContentJson)
          : null,
      lessonQuest: lessonQuestJson != null
          ? (lessonQuestJson as List)
              .map((e) => LessonQuestModel.fromJson(e))
              .toList()
          : [],
      status: json['status']?.toString() ?? '',
    );
  }
}
