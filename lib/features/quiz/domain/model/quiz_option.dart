class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;
  final int weight;

  QuizOption({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.weight,
  });
}
