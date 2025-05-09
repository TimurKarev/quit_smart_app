import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/quiz/ui/bloc/quiz_controller/quiz_controller_bloc.dart';

import 'widgets/quiz_option_widget.dart';

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
    final String previousButtonText = "Previous";
    final String nextButtonText = "Next";
    final String submitButtonText = "Submit";
    final String resultsTitleText = "Quiz Results";
    final String scoreText = "Your Score:";
    final String tryAgainButtonText = "Try Again";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement Information action
            },
            child: Text(
              informationText,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
              onPressed: () {
                // TODO: Implement Login action
              },
              child: Text(loginButtonText),
            ),
          ),
        ],
        backgroundColor: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow.withOpacity(0.1),
      ),
      body: BlocBuilder<QuizControllerBloc, QuizControllerState>(
        builder: (context, state) {
          if (state is QuizControllerInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizControllerInProgress) {
            final currentQuestion = state.currentQuestion;
            final progress =
                (state.currentQuestionIndex + 1) / state.quiz.questions.length;
            final questionProgressText =
                "Question ${state.currentQuestionIndex + 1} of ${state.quiz.questions.length}";
            final progressCompleteText =
                "${(progress * 100).toInt()}% Complete";

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
                                    colorScheme.primary,
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
                          style: const TextStyle(fontSize: 18),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                              ),
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
                                state.isLastQuestion
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultsTitleText, style: textTheme.headlineMedium),
                    const SizedBox(height: 24),
                    Text(
                      '$scoreText ${state.score}',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 32),
                    Text(state.resultText, style: textTheme.titleLarge),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        context.read<QuizControllerBloc>().add(
                          QuizControllerInitialized(quiz: state.quiz),
                        );
                      },
                      child: Text(tryAgainButtonText),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is QuizControllerFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("An unexpected error occurred."));
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        child: Text(
          ' 2025 QuitSmart. All rights reserved.',
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
