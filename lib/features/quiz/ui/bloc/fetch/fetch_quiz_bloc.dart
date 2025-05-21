import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_model.dart';
import 'package:quit_smart_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quit_smart_app/utils/bloc/bloc_state.dart';
import 'package:quit_smart_app/utils/data/either.dart';

part 'fetch_quiz_event.dart';
part 'fetch_quiz_state.dart';

class FetchQuizBloc extends Bloc<FetchQuizEvent, FetchQuizState> {
  final QuizRepository _quizRepository;

  FetchQuizBloc({required QuizRepository quizRepository})
      : _quizRepository = quizRepository,
        super(FetchQuizState.initial()) {
    on<FetchQuizRequested>(_onFetchQuizRequested);
  }

  Future<void> _onFetchQuizRequested(
    FetchQuizRequested event,
    Emitter<FetchQuizState> emit,
  ) async {
    emit(state.copyWith(
      blocState: BlocState.loading,
    ));
    final Either<QuizModel> result = await _quizRepository.getQuiz(
      path: '/startQuizes/FTND/questions',
      locale: event.locale,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        blocState: BlocState.failure,
        error: failure.message,
      )),
      (quiz) => emit(state.copyWith(
        blocState: BlocState.success,
        quiz: quiz,
      )),
    );
  }
}
