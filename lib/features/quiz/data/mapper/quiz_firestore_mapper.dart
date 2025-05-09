import 'package:quit_smart_app/features/quiz/domain/model/quiz_models.dart';
import 'package:quit_smart_app/utils/data/failure.dart';

class QuizFirestoreMapper {
  static QuizOption quizOptionFromMap(Map<String, dynamic> data) {
    try {
      return QuizOption(
        text: data['text'] as String,
        weight: data['weight'] as int,
      );
    } catch (e) {
      throw Failure(
        type: FailureType.dataMappingFailure,
        message: 'Error mapping QuizOption: ${e.toString()}. Data: $data',
      );
    }
  }

  static QuizQuestion quizQuestionFromMap(Map<String, dynamic> data) {
    try {
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
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure(
        type: FailureType.dataMappingFailure,
        message: 'Error mapping QuizQuestion: ${e.toString()}. Data: $data',
      );
    }
  }
}
