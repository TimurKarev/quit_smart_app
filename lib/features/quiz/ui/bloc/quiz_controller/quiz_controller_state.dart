part of 'quiz_controller_bloc.dart';

sealed class QuizControllerState extends Equatable {
  const QuizControllerState();

  @override
  List<Object?> get props => [];
}

final class QuizControllerInitial extends QuizControllerState {}

final class QuizControllerLoading extends QuizControllerState {}

class QuizControllerInProgress extends QuizControllerState {
  final QuizModel quiz;
  final int currentQuestionIndex;
  final Map<String, QuizOption?>
  selectedAnswers; // questionId to selected QuizOption

  const QuizControllerInProgress({
    required this.quiz,
    required this.currentQuestionIndex,
    required this.selectedAnswers,
  });

  QuizQuestion get currentQuestion => quiz.questions[currentQuestionIndex];

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

  @override
  List<Object?> get props => [quiz, currentQuestionIndex, selectedAnswers];
}

class QuizControllerResult extends QuizControllerState {
  final int score;
  final SmokingStageResult smokingStageResult;
  final QuizModel quiz; // Keep for potential retry

  const QuizControllerResult({
    required this.score,
    required this.smokingStageResult,
    required this.quiz,
  });

  @override
  List<Object?> get props => [score, smokingStageResult, quiz];
}

class QuizControllerFailure extends QuizControllerState {
  final String message;
  final QuizModel? quiz; // For retrying the specific quiz

  const QuizControllerFailure({required this.message, this.quiz});

  @override
  List<Object?> get props => [message, quiz];
}
