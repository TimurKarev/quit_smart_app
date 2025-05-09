import 'package:flutter/material.dart';
// import 'package:quit_smart_app/routing/app_router.dart'; // Unused for now
// import 'package:quit_smart_app/ui/theme/app_theme.dart'; // Unused for now
// import 'package:go_router/go_router.dart'; // Unused for now
// TODO: Replace with actual l10n import if available
// import 'package:quit_smart_app/generated/l10n/app_localizations.dart';

import 'widgets/quiz_option_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // TODO: Replace with actual data and logic from BLoC or ViewModel
  int _currentQuestionIndex = 1; // Example: 2nd question
  int _totalQuestions = 5;
  String _questionText = "How many cigarettes do you smoke per day?";
  List<String> _options = [
    "Less than 5 cigarettes",
    "5-10 cigarettes",
    "11-20 cigarettes",
    "More than 20 cigarettes",
  ];
  int? _selectedOptionIndex = 2; // Example: 3rd option selected

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _nextQuestion() {
    // TODO: Implement navigation to the next question or results
    if (_currentQuestionIndex < _totalQuestions) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null; // Reset selection for next question
        // Typically, you'd fetch the next question's data here
      });
    } else {
      // Navigate to results page or similar
      // context.push(AppRoutes.quizResult);
    }
  }

  void _previousQuestion() {
    // TODO: Implement navigation to the previous question
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedOptionIndex = null; // Reset selection or load previous answer
        // Typically, you'd fetch the previous question's data here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    // final l10n = AppLocalizations.of(context)!; // Uncomment when l10n is set up

    // Placeholder strings - replace with l10n
    final String appBarTitle = "QuitSmart";
    final String informationText = "Information";
    final String loginButtonText = "Login";
    final String questionProgressText =
        "Question ${_currentQuestionIndex + 1} of $_totalQuestions";
    final String progressCompleteText =
        "${((_currentQuestionIndex + 1) / _totalQuestions * 100).toInt()}% Complete";
    final String assessmentTitle = "Smoking Habits Assessment";
    final String previousButtonText = "Previous";
    final String nextButtonText = "Next";
    final String footerText = " 2025 QuitSmart. All rights reserved.";

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle,
            style: textTheme.headlineSmall
                ?.copyWith(color: colorScheme.onSurface)),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement Information action
            },
            child: Text(
              informationText,
              style: textTheme.labelLarge
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                // context.push(AppRoutes.login);
              },
              child: Text(loginButtonText),
            ),
          ),
        ],
        backgroundColor: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 600), // Adjusted for typical quiz width
            child: Padding(
              padding: const EdgeInsets.all(
                  24.0), // Increased padding for main content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress Section
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(questionProgressText,
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                            Text(progressCompleteText,
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: LinearProgressIndicator(
                            value:
                                (_currentQuestionIndex + 1) / _totalQuestions,
                            backgroundColor: colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.primary),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Question Title
                  Text(
                    assessmentTitle,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Question Text
                  Text(
                    _questionText,
                    style: textTheme.titleLarge
                        ?.copyWith(color: colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Options
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      return QuizOptionWidget(
                        text: _options[index],
                        isSelected: _selectedOptionIndex == index,
                        onTap: () => _selectOption(index),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  ),
                  const SizedBox(height: 32),

                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: _currentQuestionIndex == 0
                            ? null
                            : _previousQuestion, // Disable if first question
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colorScheme.outline),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(previousButtonText),
                      ),
                      ElevatedButton(
                        onPressed: _selectedOptionIndex == null
                            ? null
                            : _nextQuestion, // Disable if no option selected
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(nextButtonText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(16.0),
      //   decoration: BoxDecoration(
      //     border: Border(top: BorderSide(color: colorScheme.outline.withOpacity(0.5))),
      //     color: colorScheme.surface,
      //   ),
      //   child: Center(
      //     child: Text(
      //       footerText,
      //       style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
      //     ),
      //   ),
      // ),
    );
  }
}

/*
class _QuizOptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOptionItem({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer.withOpacity(0.3) : colorScheme.surfaceVariant.withOpacity(0.3),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: textTheme.bodyLarge?.copyWith(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
