import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';
import 'package:quit_smart_app/utils/data/either.dart';

abstract class QuizRepository {
  Future<Either<QuizModel>> getQuiz({
    required String path,
  });
  Future<Either<void>> saveQuizResult(QuizModel quiz, String userId);
}
