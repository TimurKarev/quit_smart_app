import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quit_smart_app/features/quiz/ui/bloc/fetch/fetch_quiz_bloc.dart';
import 'package:quit_smart_app/features/quiz/ui/bloc/quiz_controller/quiz_controller_bloc.dart';
import 'package:quit_smart_app/features/quiz/ui/quiz_screen.dart';
import 'package:quit_smart_app/utils/bloc/bloc_state.dart';
import 'package:quit_smart_app/utils/di/app_di.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => FetchQuizBloc(
                quizRepository: context.read<AppDi>().get<QuizRepository>(),
              )..add(FetchQuizRequested()),
        ),
        BlocProvider(create: (context) => QuizControllerBloc()),
      ],
      child: BlocListener<FetchQuizBloc, FetchQuizState>(
        listener: (context, state) {
          if (state.blocState == BlocState.success) {
            context.read<QuizControllerBloc>().add(
              QuizControllerInitialized(quiz: state.quiz),
            );
          }
        },
        child: const QuizScreen(),
      ),
    );
  }
}
