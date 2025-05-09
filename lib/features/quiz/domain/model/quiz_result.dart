class RecommendationItem {
  final String title;
  final String subtitle;
  // final IconData? icon; // Optional: if you want icons per recommendation

  const RecommendationItem({
    required this.title,
    required this.subtitle,
    // this.icon,
  });
}

class SmokingStageResult {
  final String completionTitle;
  final String completionMessage;
  final String stageName;
  final String stageDescription;
  // final IconData? stageIcon; // Optional: if you want an icon for the stage
  final List<RecommendationItem> recommendations;
  final String actionButtonText;

  const SmokingStageResult({
    required this.completionTitle,
    required this.completionMessage,
    required this.stageName,
    required this.stageDescription,
    // this.stageIcon,
    required this.recommendations,
    required this.actionButtonText,
  });

  // Example of a factory constructor for a specific stage, e.g., Contemplation
  factory SmokingStageResult.contemplation() {
    return const SmokingStageResult(
      completionTitle: "Assessment Complete!",
      completionMessage: "Based on your responses, we've identified your smoking stage.",
      stageName: "Contemplation",
      stageDescription: "You're thinking about quitting smoking but haven't made concrete plans yet.",
      // stageIcon: Icons.lightbulb_outline,
      recommendations: [
        RecommendationItem(title: "Set a Quit Date", subtitle: "Choose a date within the next two weeks"),
        RecommendationItem(title: "Join Support Group", subtitle: "Connect with others on journey"),
        RecommendationItem(title: "Track Progress", subtitle: "Monitor your quit journey"),
        RecommendationItem(title: "Get Resources", subtitle: "Access helpful materials"),
      ],
      actionButtonText: "Join QuitSmart App Today",
    );
  }

  factory SmokingStageResult.precontemplation() {
    return const SmokingStageResult(
      completionTitle: "Assessment Complete!",
      completionMessage: "Understanding your current perspective is the first step.",
      stageName: "Precontemplation",
      stageDescription: "You may not yet be considering quitting smoking, or have not recognized it as a problem.",
      recommendations: [
        RecommendationItem(title: "Learn About Risks", subtitle: "Understand smoking health effects"),
        RecommendationItem(title: "Reflect on Benefits", subtitle: "Consider life without smoking"),
        RecommendationItem(title: "Talk to Someone", subtitle: "Share thoughts with a trusted person"),
        RecommendationItem(title: "No Pressure Info", subtitle: "Explore resources at your own pace"),
      ],
      actionButtonText: "Learn More & Explore",
    );
  }

  factory SmokingStageResult.preparation() {
    return const SmokingStageResult(
      completionTitle: "Ready to Take Action!",
      completionMessage: "You're preparing to make a change. That's a significant step!",
      stageName: "Preparation",
      stageDescription: "You're planning to quit soon and are taking steps towards that goal.",
      recommendations: [
        RecommendationItem(title: "Set a Firm Quit Date", subtitle: "Commit to a specific day"),
        RecommendationItem(title: "Tell Friends & Family", subtitle: "Build your support network"),
        RecommendationItem(title: "Remove Triggers", subtitle: "Clean your environment of cues"),
        RecommendationItem(title: "Plan Coping Strategies", subtitle: "Prepare for cravings & challenges"),
      ],
      actionButtonText: "Finalize Your Quit Plan",
    );
  }

  factory SmokingStageResult.action() {
    return const SmokingStageResult(
      completionTitle: "You're Doing It!",
      completionMessage: "You've recently quit smoking. Keep up the great work!",
      stageName: "Action",
      stageDescription: "You've actively stopped smoking and are working on staying smoke-free.",
      recommendations: [
        RecommendationItem(title: "Manage Cravings", subtitle: "Use techniques to overcome urges"),
        RecommendationItem(title: "Stay Active", subtitle: "Exercise can help reduce stress"),
        RecommendationItem(title: "Reward Yourself", subtitle: "Acknowledge your achievements"),
        RecommendationItem(title: "Seek Ongoing Support", subtitle: "Continue with support groups/apps"),
      ],
      actionButtonText: "Track Your Progress & Stay Strong",
    );
  }

  factory SmokingStageResult.maintenance() {
    return const SmokingStageResult(
      completionTitle: "Staying Strong!",
      completionMessage: "You've been smoke-free for a while. Consistency is key!",
      stageName: "Maintenance",
      stageDescription: "You're working to prevent relapse and maintain your non-smoking status long-term.",
      recommendations: [
        RecommendationItem(title: "Identify Relapse Triggers", subtitle: "Be aware of high-risk situations"),
        RecommendationItem(title: "Celebrate Milestones", subtitle: "Recognize your continued success"),
        RecommendationItem(title: "Help Others Quit", subtitle: "Share your experience & inspire"),
        RecommendationItem(title: "Lifelong Vigilance", subtitle: "Commit to a smoke-free life"),
      ],
      actionButtonText: "Continue Your Healthy Journey",
    );
  }

  factory SmokingStageResult.error({
    required String errorMessage,
    String actionButtonText = "Try Again",
  }) {
    return SmokingStageResult(
      completionTitle: "An Error Occurred",
      completionMessage: errorMessage,
      stageName: "Error",
      stageDescription: "We encountered an issue. Please try again.",
      recommendations: [], // No recommendations for a generic error
      actionButtonText: actionButtonText,
    );
  }
}
