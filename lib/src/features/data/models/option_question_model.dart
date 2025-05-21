  class OptionTestModel {
    final int idQuizOption;
    final int idQuestLesson;
    final String titleQuestion;
    final int setTime;
    final List<QuestionModel> questions;
    final List<AnswerModel> answers;

    OptionTestModel({
      required this.idQuizOption,
      required this.idQuestLesson,
      required this.titleQuestion,
      required this.setTime,
      required this.questions,
      required this.answers,
    });

    factory OptionTestModel.fromJson(Map<String, dynamic> json) {
      return OptionTestModel(
        idQuizOption: json['id_quiz_option'],
        idQuestLesson: json['id_quest_lesson'],
        titleQuestion: json['title_question'],
        setTime: json['set_time'],
        questions: List<QuestionModel>.from(
          json['question'].map((x) => QuestionModel.fromJson(x)),
        ),
        answers: List<AnswerModel>.from(
          json['answer'].map((x) => AnswerModel.fromJson(x)),
        ),
      );
    }
  }

  class QuestionModel {
    final String type;
    final String content;
    final String questDesc;

    QuestionModel({
      required this.type,
      required this.content,
      required this.questDesc,
    });

    factory QuestionModel.fromJson(Map<String, dynamic> json) {
      return QuestionModel(
        type: json['question_quiz']['type'],
        content: json['question_quiz']['content'],
        questDesc: json['quest_desc'],
      );
    }
  }

  class AnswerModel {
    final List<OptionModel> options;
    final String correctAnswer;

    AnswerModel({
      required this.options,
      required this.correctAnswer,
    });

    factory AnswerModel.fromJson(Map<String, dynamic> json) {
      return AnswerModel(
        options: List<OptionModel>.from(
          json['option_question'].map((x) => OptionModel.fromJson(x)),
        ),
        correctAnswer: json['question_answer'],
      );
    }
  }

  class OptionModel {
    final String optionId;
    final String type;
    final String content;

    OptionModel({
      required this.optionId,
      required this.type,
      required this.content,
    });

    factory OptionModel.fromJson(Map<String, dynamic> json) {
      return OptionModel(
        optionId: json['option_id'],
        type: json['type'],
        content: json['content'],
      );
    }
  }
