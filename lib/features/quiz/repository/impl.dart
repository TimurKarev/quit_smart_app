import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quit_smart_app/features/quiz/data/mapper/quiz_mapper.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';
import 'package:quit_smart_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quit_smart_app/utils/data/either.dart';
import 'package:quit_smart_app/utils/data/failure.dart';
import 'package:quit_smart_app/utils/firebase/firestore_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final FirestoreService _firestoreService;

  QuizRepositoryImpl(
      {FirestoreService? firestoreService,
      FirebaseFirestore? directFirestoreInstance})
      : _firestoreService = firestoreService ??
            FirestoreServiceImpl(FirebaseFirestore.instance);

  @override
  Future<Either<QuizModel>> getQuiz({
    required String path,
  }) async {
    try {
      final List<QuizQuestion> questions =
          await _firestoreService.getCollection<QuizQuestion>(
        path: path,
        mapper: (documentData) =>
            QuizFirestoreMapper.quizQuestionFromMap(documentData),
      );

      if (questions.isEmpty) {
        return Either.error(Failure(
            type: FailureType.firestoreOperationFailure,
            message: 'No questions found in the quiz'));
      }

      return Either.success(QuizModel(questions: questions));
    } on Failure catch (failure) {
      return Either.error(failure);
    } catch (e) {
      return Either.error(Failure(
          type: FailureType.unknown,
          message: 'Unexpected error in getQuiz: ${e.toString()}'));
    }
  }

  @override
  Future<Either<void>> saveQuizResult(QuizModel quiz, String userId) async {
    try {
      final quizResultData = {
        'userId': userId,
        'quizId': 'stage_quiz',
        'timestamp': FieldValue.serverTimestamp(),
        'score': 0,
        'answers': quiz.questions
            .map((q) => {
                  'questionId': q.id,
                  'selectedOptionId': '',
                  'isCorrect': false,
                })
            .toList(),
      };

      return Either.success(null);
    } on FirebaseException catch (e) {
      return Either.error(Failure(
          type: FailureType.firestoreOperationFailure,
          message: 'Firestore error saving quiz result: ${e.message}'));
    } catch (e) {
      return Either.error(Failure(
          type: FailureType.dataMappingFailure,
          message: 'Error saving quiz result: ${e.toString()}'));
    }
  }
}
