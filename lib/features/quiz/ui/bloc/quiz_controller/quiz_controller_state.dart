part of 'quiz_controller_bloc.dart';

abstract class QuizControllerState extends Equatable {
  const QuizControllerState();

  @override
  List<Object?> get props => [];
}

class QuizControllerInitial extends QuizControllerState {}

class QuizControllerInProgress extends QuizControllerState {
  final QuizModel quiz;
  final int currentQuestionIndex;
  final Map<String, QuizOption?>
  selectedAnswers; // questionId -> selectedOption

  const QuizControllerInProgress({
    required this.quiz,
    required this.currentQuestionIndex,
    required this.selectedAnswers,
  });

  QuizQuestion get currentQuestion => quiz.questions[currentQuestionIndex];
  bool get isLastQuestion => currentQuestionIndex == quiz.questions.length - 1;

  @override
  List<Object?> get props => [quiz, currentQuestionIndex, selectedAnswers];

  QuizControllerInProgress copyWith({
    QuizModel? quiz,
    int? currentQuestionIndex,
    Map<String, QuizOption?>? selectedAnswers,
  }) {
    return QuizControllerInProgress(
      quiz: quiz ?? this.quiz,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}

class QuizControllerResult extends QuizControllerState {
  final QuizModel quiz;
  final Map<String, QuizOption?> selectedAnswers;
  final int score;
  final int totalQuestions;
  final String resultText;

  const QuizControllerResult({
    required this.quiz,
    required this.selectedAnswers,
    required this.score,
    required this.totalQuestions,
    required this.resultText,
  });

  @override
  List<Object?> get props => [
    quiz,
    selectedAnswers,
    score,
    totalQuestions,
    resultText,
  ];
}

class QuizControllerFailure extends QuizControllerState {
  final String message;

  const QuizControllerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
