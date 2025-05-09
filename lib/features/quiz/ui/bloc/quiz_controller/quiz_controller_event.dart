part of 'quiz_controller_bloc.dart';

abstract class QuizControllerEvent extends Equatable {
  const QuizControllerEvent();

  @override
  List<Object?> get props => [];
}

class QuizControllerInitialized extends QuizControllerEvent {
  final QuizModel quiz;

  const QuizControllerInitialized({required this.quiz});

  @override
  List<Object?> get props => [quiz];
}

class QuizControllerAnswerSelected extends QuizControllerEvent {
  final String questionId;
  final QuizOption selectedOption;

  const QuizControllerAnswerSelected({
    required this.questionId,
    required this.selectedOption,
  });

  @override
  List<Object?> get props => [questionId, selectedOption];
}

class QuizControllerNextQuestion extends QuizControllerEvent {}

class QuizControllerSubmitted extends QuizControllerEvent {}
