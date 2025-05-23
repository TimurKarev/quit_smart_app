import 'package:quit_smart_app/features/quiz/domain/model/quiz_models.dart';
import 'package:quit_smart_app/utils/data/failure.dart';

class QuizFirestoreMapper {
  static QuizOption quizOptionFromMap(Map<String, dynamic> data, String lang) {
    try {
      return QuizOption(
        id: data['id'] as String? ?? '',
        text: data['text'][lang] as String,
        weight: data['weight'] as int,
      );
    } catch (e) {
      throw Failure(
        type: FailureType.dataMappingFailure,
        message: 'Error mapping QuizOption: ${e.toString()}. Data: $data',
      );
    }
  }

  static QuizQuestion quizQuestionFromMap(
      Map<String, dynamic> data, String lang) {
    try {
      final optionsList = data['options'] as List<dynamic>? ?? [];
      final List<QuizOption> parsedOptions = optionsList
          .map(
            (optionData) =>
                quizOptionFromMap(optionData as Map<String, dynamic>, lang),
          )
          .toList();

      return QuizQuestion(
        id: data['id'] as String,
        questionText: data['questionText'][lang] as String,
        options: parsedOptions,
        questionType: data['questionType'] as String,
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure(
        type: FailureType.dataMappingFailure,
        message: 'Error mapping QuizQuestion: ${e.toString()}. Data: $data',
      );
    }
  }
}
