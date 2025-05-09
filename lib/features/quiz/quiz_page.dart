import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quit_smart_app/features/quiz/ui/bloc/fetch/fetch_quiz_bloc.dart';
import 'package:quit_smart_app/features/quiz/ui/quiz_screen.dart';
import 'package:quit_smart_app/utils/di/app_di.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => FetchQuizBloc(
        quizRepository: context.read<AppDi>().get<QuizRepository>(),
      )..add(FetchQuizRequested()),
      child: const QuizScreen(),
    );
  }
}
