import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quit_smart_app/features/auth/domain/models/app_user.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';
import 'package:quit_smart_app/features/auth/ui/sing_in_page.dart';
import 'package:quit_smart_app/features/home/home_page.dart';
import 'package:quit_smart_app/features/home/ui/screens/screens.dart';
import 'package:quit_smart_app/features/landing/landing_page.dart';
import 'package:quit_smart_app/features/onboarding/onboarding_page.dart';
import 'package:quit_smart_app/features/quiz/quiz_page.dart';

// Private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorDiaryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDiary');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

// Define route paths
class AppRoutes {
  static const String landing = '/landing';
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String diary = '/diary';
  static const String profile = '/profile';
  static const String quiz = '/quiz';
}

// Function to create the GoRouter instance
GoRouter createAppRouter(AuthBloc authBloc) {
  print(
      '[AppRouter] createAppRouter called. Initial AuthBloc state: ${authBloc.state}');
  return GoRouter(
    initialLocation: AppRoutes.landing, // Start at landing
    refreshListenable: GoRouterRefreshStream(authBloc),
    navigatorKey: _rootNavigatorKey, // Use the static key from Router class
    redirect: (BuildContext context, GoRouterState state) {
      final authState = authBloc.state;
      final user = authState.user;

      final bool isAuth = user is AuthenticatedUser;
      final bool isUnauth = user is UnauthenticatedUser;
      final bool isUnknown = user is UnknownUser;

      final String location = state.matchedLocation;
      debugPrint('[AppRouter] Redirect: Current location: $location, Auth state: ${user.runtimeType}');

      if (isUnknown && location == AppRoutes.landing) {
        debugPrint('[AppRouter] Redirect: Unknown user on landing page, staying.');
        return null;
      }
      if (isUnknown && location != AppRoutes.landing) {
        debugPrint('[AppRouter] Redirect: Unknown user not on landing, redirecting to landing.');
        return AppRoutes.landing;
      }

      if (isAuth) {
        if (location == AppRoutes.landing || location == AppRoutes.onboarding || location == AppRoutes.signIn) {
          debugPrint('[AppRouter] Redirect: Authenticated user on public page, redirecting to home.');
          return AppRoutes.home;
        }
        debugPrint('[AppRouter] Redirect: Authenticated user on allowed page, staying.');
        return null;
      }

      if (isUnauth) {
        // If user becomes Unauthenticated and is currently on the LandingPage,
        // redirect them to Onboarding.
        if (location == AppRoutes.landing) {
          debugPrint('[AppRouter] Redirect: Unauthenticated user on landing, redirecting to onboarding.');
          return AppRoutes.onboarding;
        }
        // If already on onboarding, signIn, OR THE TARGET IS QUIZ, allow them to stay/proceed.
        debugPrint('[AppRouter] DIAGNOSTIC: Comparing location "$location" with AppRoutes.quiz "${AppRoutes.quiz}"');
        if (location == AppRoutes.onboarding || location == AppRoutes.signIn || location == AppRoutes.quiz) {
          debugPrint('[AppRouter] Redirect: Unauthenticated user on or going to onboarding/signIn/quiz, allowing ($location).');
          return null;
        }
        // If trying to access a protected route (home, diary, profile), redirect to onboarding.
        if (location.startsWith(AppRoutes.home) || location == AppRoutes.diary || location == AppRoutes.profile) {
          debugPrint('[AppRouter] Redirect: Unauthenticated user on protected route ($location), redirecting to onboarding.');
          return AppRoutes.onboarding;
        }
        // Fallback: if not on a known public-allowed route for unauthenticated users, send to onboarding.
        debugPrint('[AppRouter] Redirect: Unauthenticated user on unhandled route, redirecting to onboarding as fallback.');
        return AppRoutes.onboarding; 
      }
      
      debugPrint('[AppRouter] Redirect: No specific redirect rule matched, falling back to landing. THIS SHOULD RARELY HAPPEN.');
      return AppRoutes.landing;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.landing,
        builder: (BuildContext context, GoRouterState state) =>
            const LandingPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (BuildContext context, GoRouterState state) =>
            const SignInPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomePage(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeTabScreen(), // Uses placeholder
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDiaryKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.diary,
                builder: (BuildContext context, GoRouterState state) =>
                    const DiaryTabScreen(), // Uses placeholder
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profile,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfileTabScreen(), // Uses placeholder
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) => const QuizPage(),
      ),
    ],
    // TODO: Add error handling (e.g., errorBuilder for 404)
  );
}

// Helper class to make GoRouter refresh when AuthBloc state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(AuthBloc authBloc) {
    notifyListeners();
    _subscription = authBloc.stream.asBroadcastStream().listen(
      (dynamic _) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Static key for navigator access
class Router {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
