import 'package:flutter/material.dart';
import 'package:quit_smart_app/features/quiz/domain/model/quiz_result.dart';

class QuizResultView extends StatelessWidget {
  final SmokingStageResult smokingStageResult;
  final VoidCallback onButtonPressed;

  const QuizResultView({
    super.key,
    required this.smokingStageResult,
    required this.onButtonPressed,
  });

  Widget _buildCompletionSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(
            12.0,
          ), // p-4 equivalent for icon container
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant, // bg-neutral-100
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons
                .check_circle_outline, // Consider making dynamic if smokingStageResult.stageIcon is used
            size: 40,
            color: colorScheme.onSurfaceVariant, // text-neutral-800
          ),
        ),
        const SizedBox(height: 16), // mb-4
        Text(
          smokingStageResult.completionTitle,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ), // text-2xl
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8), // mb-2
        Text(
          smokingStageResult.completionMessage,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ), // text-neutral-600
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStageResultSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24.0), // p-6
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant, // bg-neutral-100
        borderRadius: BorderRadius.circular(8.0), // rounded-lg
      ),
      child: Column(
        children: [
          Text(
            "Your Current Stage: ${smokingStageResult.stageName}",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ), // text-xl
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16), // mb-4
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                // smokingStageResult.stageIcon ?? Icons.lightbulb_outline, // Use stageIcon if available
                Icons.lightbulb_outline,
                size: 24,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 16), // gap-4
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What This Means",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ), // text-lg
                    ),
                    const SizedBox(height: 4), // mb-1
                    Text(
                      smokingStageResult.stageDescription,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ), // text-neutral-600
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(
    BuildContext context,
    RecommendationItem item,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16.0), // p-4
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300), // border-neutral-200
        borderRadius: BorderRadius.circular(8.0), // rounded-lg
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface, // bg-neutral-900
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12), // gap-3
              Expanded(
                child: Text(
                  item.title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              item.subtitle,
              style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended Next Steps",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ), // text-xl
        ),
        const SizedBox(height: 16), // mb-4
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 5,
          ),
          itemCount: smokingStageResult.recommendations.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = smokingStageResult.recommendations[index];
            return _buildRecommendationItem(context, item);
          },
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context, VoidCallback onPressed) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onSurface,
        foregroundColor: colorScheme.surface,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: onPressed,
      child: Text(smokingStageResult.actionButtonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCompletionSection(context),
            const SizedBox(height: 32),
            _buildStageResultSection(context),
            const SizedBox(height: 32),
            _buildRecommendationsSection(context),
            const SizedBox(height: 32),
            _buildActionsSection(context, onButtonPressed),
          ],
        ),
      ),
    );
  }
}
