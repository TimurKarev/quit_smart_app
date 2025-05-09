part of 'fetch_quiz_bloc.dart';

class FetchQuizState extends Equatable {
  const FetchQuizState({
    required this.blocState,
    required this.quiz,
    required this.error,
  });

  final BlocState blocState;
  final QuizModel quiz;
  final String error;

  const FetchQuizState.initial()
      : blocState = BlocState.initial,
        quiz = const QuizModel.empty(),
        error = '';

  FetchQuizState copyWith({
    BlocState? blocState,
    QuizModel? quiz,
    String? error,
  }) {
    return FetchQuizState(
      blocState: blocState ?? this.blocState,
      quiz: quiz ?? this.quiz,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        blocState,
        quiz,
        error,
      ];
}
