import 'package:quit_smart_app/features/quiz/domain/model/quiz_models.dart';

class QuizFirestoreMapper {
  static QuizOption quizOptionFromMap(Map<String, dynamic> data) {
    return QuizOption(
      text: data['text'] as String,
      weight: data['weight'] as int,
    );
  }

  static QuizQuestion quizQuestionFromMap(Map<String, dynamic> data) {
    final optionsList = data['options'] as List<dynamic>? ?? [];
    final List<QuizOption> parsedOptions = optionsList
        .map((optionData) =>
            quizOptionFromMap(optionData as Map<String, dynamic>))
        .toList();

    return QuizQuestion(
      id: data['id'] as String,
      questionText: data['questionText'] as String,
      options: parsedOptions,
      questionType: data['questionType'] as String,
    );
  }
}
