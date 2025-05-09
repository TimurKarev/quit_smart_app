import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';

part 'quiz_controller_event.dart';
part 'quiz_controller_state.dart';

class QuizControllerBloc extends Bloc<QuizControllerEvent, QuizControllerState> {
  QuizControllerBloc() : super(QuizControllerInitial()) {
    on<QuizControllerInitialized>(_onQuizControllerInitialized);
    on<QuizControllerAnswerSelected>(_onQuizControllerAnswerSelected);
    on<QuizControllerNextQuestion>(_onQuizControllerNextQuestion);
    on<QuizControllerPrevQuestion>(_onQuizControllerPrevQuestion);
  }

  Future<void> _onQuizControllerInitialized(
    QuizControllerInitialized event,
    Emitter<QuizControllerState> emit,
  ) async {
    emit(QuizControllerInProgress(
      quiz: event.quiz,
      currentQuestionIndex: 0,
      selectedAnswers: {},
    ));
  }

  Future<void> _onQuizControllerAnswerSelected(
    QuizControllerAnswerSelected event,
    Emitter<QuizControllerState> emit,
  ) async {
    if (state is QuizControllerInProgress) {
      final currentState = state as QuizControllerInProgress;
      final newSelectedAnswers = Map<String, QuizOption>.from(currentState.selectedAnswers);
      newSelectedAnswers[event.questionId] = event.selectedOption;
      emit(currentState.copyWith(selectedAnswers: newSelectedAnswers));
    }
  }

  Future<void> _onQuizControllerNextQuestion(
    QuizControllerNextQuestion event,
    Emitter<QuizControllerState> emit,
  ) async {
    if (state is QuizControllerInProgress) {
      final currentState = state as QuizControllerInProgress;
      if (currentState.isLastQuestion) {
        // Calculate score
        int score = 0;
        currentState.quiz.questions.asMap().forEach((index, question) {
          final selectedOption = currentState.selectedAnswers[question.id];
          if (selectedOption != null && selectedOption.isCorrect) {
            score++;
          }
        });
        emit(QuizControllerResult(
          quiz: currentState.quiz,
          selectedAnswers: currentState.selectedAnswers,
          score: score,
          totalQuestions: currentState.quiz.questions.length,
        ));
      } else {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
        ));
      }
    }
  }

  Future<void> _onQuizControllerPrevQuestion(
    QuizControllerPrevQuestion event,
    Emitter<QuizControllerState> emit,
  ) async {
    if (state is QuizControllerInProgress) {
      final currentState = state as QuizControllerInProgress;
      if (currentState.currentQuestionIndex > 0) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
        ));
      }
    }
  }
}
