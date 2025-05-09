import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/quiz/ui/bloc/quiz_controller/quiz_controller_bloc.dart';
import 'package:quit_smart_app/ui/theme/app_theme.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_result.dart';

import 'widgets/quiz_option_widget.dart';
import 'widgets/quiz_result_view.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _QuizScreenView();
  }
}

class _QuizScreenView extends StatelessWidget {
  const _QuizScreenView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final String appBarTitle = "QuitSmart";
    final String informationText = "Information";
    final String loginButtonText = "Login";
    final String assessmentTitle = "Smoking Habits Assessment";

    // Strings for QuizResultView
    const String resultsTitleText = "Quiz Results";
    const String scoreLabelText = "Your Score:";
    const String errorTitleText = "Error Occurred";
    const String tryAgainButtonText = "Try Again";

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement Information action
            },
            child: Text(informationText, style: AppTheme.appBarActionTextStyle),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement Login action
              },
              child: Text(loginButtonText),
            ),
          ),
        ],
      ),
      body: BlocBuilder<QuizControllerBloc, QuizControllerState>(
        builder: (context, state) {
          if (state is QuizControllerInitial) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is QuizControllerInProgress) {
            final currentQuestion = state.currentQuestion;
            final progress =
                (state.currentQuestionIndex + 1) / state.quiz.questions.length;
            final questionProgressText =
                "Question ${state.currentQuestionIndex + 1} of ${state.quiz.questions.length}";
            final progressCompleteText =
                "${(progress * 100).toInt()}% Complete";

            // TODO: Replace with l10n
            const String previousButtonText = "Previous";
            const String nextButtonText = "Next";
            const String submitButtonText = "Submit";

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    questionProgressText,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    progressCompleteText,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: colorScheme.surfaceVariant,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    colorScheme.onSurface,
                                  ),
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          assessmentTitle,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          currentQuestion.questionText,
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentQuestion.options.length,
                          itemBuilder: (context, index) {
                            final option = currentQuestion.options[index];
                            final selectedOption =
                                state.selectedAnswers[currentQuestion.id];
                            return QuizOptionWidget(
                              text: option.text,
                              isSelected: selectedOption == option,
                              onTap: () {
                                context.read<QuizControllerBloc>().add(
                                  QuizControllerAnswerSelected(
                                    questionId: currentQuestion.id,
                                    selectedOption: option,
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 12),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed:
                                  (state.currentQuestionIndex > 0)
                                      ? () {
                                        context.read<QuizControllerBloc>().add(
                                          QuizControllerPrevQuestion(),
                                        );
                                      }
                                      : null,
                              child: Text(previousButtonText),
                            ),
                            ElevatedButton(
                              onPressed:
                                  state.selectedAnswers[currentQuestion.id] ==
                                          null
                                      ? null
                                      : () {
                                        context.read<QuizControllerBloc>().add(
                                          QuizControllerNextQuestion(),
                                        );
                                      },
                              child: Text(
                                state.currentQuestionIndex ==
                                        state.quiz.questions.length - 1
                                    ? submitButtonText
                                    : nextButtonText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is QuizControllerResult) {
            return QuizResultView(
              smokingStageResult: state.smokingStageResult,
              onButtonPressed: () {
                context.read<QuizControllerBloc>().add(
                  QuizControllerInitialized(quiz: state.quiz),
                );
              },
            );
          } else if (state is QuizControllerFailure) {
            return QuizResultView(
              smokingStageResult: SmokingStageResult.error(
                errorMessage: state.message,
                actionButtonText: state.quiz != null ? "Try Again" : "Go Back",
              ),
              onButtonPressed: () {
                if (state.quiz != null) {
                  context.read<QuizControllerBloc>().add(
                    QuizControllerInitialized(quiz: state.quiz!),
                  );
                } else {
                  // If no quiz data in failure, pop the screen
                  // Or dispatch an event to navigate to a different screen
                  Navigator.of(context).pop();
                }
              },
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
