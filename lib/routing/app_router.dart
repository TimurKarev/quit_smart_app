import 'package:go_router/go_router.dart';
import 'package:quit_smart_app/features/onboarding/onboarding_page.dart';
import 'package:quit_smart_app/features/quiz/quiz_page.dart';

// Define route paths
class AppRoutes {
  static const String onboarding = '/';
  static const String quiz = '/quiz';
}

// Configure the GoRouter
final GoRouter router = GoRouter(
  initialLocation: AppRoutes.onboarding, // Start at onboarding
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.quiz,
      builder: (context, state) => const QuizPage(),
    ),
  ],
  // TODO: Add error handling (e.g., errorBuilder for 404)
);
