import 'quiz_option.dart';

class QuizQuestion {
  final String id;
  final String questionText;
  final List<QuizOption> options;
  final String questionType;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.questionType,
  });
}
