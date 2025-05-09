import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_result.dart';

part 'quiz_controller_event.dart';
part 'quiz_controller_state.dart';

class QuizControllerBloc
    extends Bloc<QuizControllerEvent, QuizControllerState> {
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
    emit(
      QuizControllerInProgress(
        quiz: event.quiz,
        currentQuestionIndex: 0,
        selectedAnswers: {},
      ),
    );
  }

  Future<void> _onQuizControllerAnswerSelected(
    QuizControllerAnswerSelected event,
    Emitter<QuizControllerState> emit,
  ) async {
    if (state is QuizControllerInProgress) {
      final currentState = state as QuizControllerInProgress;
      final newSelectedAnswers = Map<String, QuizOption>.from(
        currentState.selectedAnswers,
      );
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
      if (currentState.currentQuestionIndex ==
          currentState.quiz.questions.length - 1) {
        int score = 0;
        currentState.selectedAnswers.forEach((questionId, selectedOption) {
          if (selectedOption != null) {
            score += selectedOption.weight;
          }
        });

        SmokingStageResult stageResult;
        if (score <= 3) {
          stageResult = SmokingStageResult.precontemplation();
        } else if (score <= 7) {
          stageResult = SmokingStageResult.contemplation();
        } else if (score <= 10) {
          stageResult = SmokingStageResult.preparation();
        } else {
          stageResult = SmokingStageResult.action();
        }

        emit(
          QuizControllerResult(
            score: score,
            smokingStageResult: stageResult,
            quiz: currentState.quiz,
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
          ),
        );
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
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex - 1,
          ),
        );
      }
    }
  }
}
