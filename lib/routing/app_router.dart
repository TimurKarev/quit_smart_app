import 'package:go_router/go_router.dart';
import 'package:quit_smart_app/features/onboarding/onboarding_page.dart';
import 'package:quit_smart_app/features/quiz/quiz_page.dart';
import 'package:quit_smart_app/features/auth/ui/sing_in_page.dart';
import 'package:quit_smart_app/features/auth/ui/create_account_page.dart';

// Define route paths
class AppRoutes {
  static const String onboarding = '/';
  static const String quiz = '/quiz';
  static const String signIn = '/signIn'; 
  static const String createAccount = '/createAccount'; 
}

// Configure the GoRouter
final GoRouter router = GoRouter(
  initialLocation: AppRoutes.onboarding, 
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.quiz,
      builder: (context, state) => const QuizPage(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInPage(), 
    ),
    GoRoute(
      path: AppRoutes.createAccount,
      builder: (context, state) => const CreateAccountPage(), 
    ),
  ],
  // TODO: Add error handling (e.g., errorBuilder for 404)
);
