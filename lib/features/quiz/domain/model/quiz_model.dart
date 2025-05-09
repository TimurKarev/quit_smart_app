export 'quiz_question.dart';
export 'quiz_option.dart';

import 'quiz_question.dart';

class QuizModel {
  final List<QuizQuestion> questions;

  const QuizModel({required this.questions});

  const QuizModel.empty() : questions = const [];

  bool get isEmpty => questions.isEmpty;
}
