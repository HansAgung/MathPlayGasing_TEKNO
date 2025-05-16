class InputTestModel {
  final int idQuizOption;
  final int idQuestLesson;
  final String titleQuestion;
  final int setTime;
  final List<OptionImage> optionImg;
  final List<OptionQuestion> question;

  InputTestModel({
    required this.idQuizOption,
    required this.idQuestLesson,
    required this.titleQuestion,
    required this.setTime,
    required this.optionImg,
    required this.question,
  });

  factory InputTestModel.fromJson(Map<String, dynamic> json) {
    return InputTestModel(
      idQuizOption: json['id_quiz_option'],
      idQuestLesson: json['id_quest_lesson'],
      titleQuestion: json['title_question'],
      setTime: json['set_time'],
      optionImg: (json['option_img'] as List)
          .map((e) => OptionImage.fromJson(e))
          .toList(),
      question: (json['question'] as List)
          .map((e) => OptionQuestion.fromJson(e))
          .toList(),
    );
  }
}

class OptionImage {
  final String img;
  final int value;

  OptionImage({
    required this.img,
    required this.value,
  });

  factory OptionImage.fromJson(Map<String, dynamic> json) {
    return OptionImage(
      img: json['img'],
      value: json['value'],
    );
  }
}

class OptionQuestion {
  final String type;
  final String content;
  final int answer;

  OptionQuestion({
    required this.type,
    required this.content,
    required this.answer,
  });

  factory OptionQuestion.fromJson(Map<String, dynamic> json) {
    return OptionQuestion(
      type: json['type'],
      content: json['type'] == 'text' ? json['content'] : json['question'],
      answer: json['answer'],
    );
  }
}
