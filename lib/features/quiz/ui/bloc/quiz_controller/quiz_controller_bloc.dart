import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';

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
      if (currentState.isLastQuestion) {
        // Calculate score
        int score = 0;
        currentState.quiz.questions.asMap().forEach((index, question) {
          final selectedOption = currentState.selectedAnswers[question.id];
          score += selectedOption?.weight ?? 0;
        });
        emit(
          QuizControllerResult(
            quiz: currentState.quiz,
            selectedAnswers: currentState.selectedAnswers,
            score: score,
            totalQuestions: currentState.quiz.questions.length,
            resultText: _getSmokingStage(score),
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

String _getSmokingStage(int totalScore) {
  if (totalScore >= 8) {
    return "Very High Dependence:\n\nRecommendations:\n- Seek professional help for smoking cessation.\n- Consider nicotine replacement therapy or other medications under medical supervision.\n- Develop a strong support system.\n- Identify and manage triggers intensely.";
  } else if (totalScore >= 6) {
    return "High Dependence:\n\nRecommendations:\n- Strongly consider professional help and counseling.\n- Explore nicotine replacement therapies or prescription medications.\n- Implement significant lifestyle changes to avoid smoking cues.\n- Set realistic quit dates and create a detailed plan.";
  } else if (totalScore == 5) {
    return "Medium Dependence:\n\nRecommendations:\n- You have a moderate level of dependence. Start planning your cessation attempt.\n- Consider using over-the-counter nicotine replacement products.\n- Identify your smoking triggers and develop coping mechanisms.\n- Seek support from friends, family, or support groups.";
  } else if (totalScore >= 3) {
    return "Low Dependence:\n\nRecommendations:\n- This is a good time to quit! Your dependence is relatively low.\n- You might benefit from behavioral strategies and support.\n- Focus on willpower and identifying reasons for quitting.\n- Consider using nicotine replacement lozenges or gum if needed.";
  } else {
    return "Very Low Dependence:\n\nRecommendations:\n- Excellent! Your dependence is very low.\n- Focus on maintaining this non-smoking status.\n- Be mindful of social situations that might lead to occasional smoking.\n- If you've quit recently, stay vigilant to prevent relapse.";
  }
}
