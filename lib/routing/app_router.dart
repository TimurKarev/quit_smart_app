import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Removed unused import
import 'package:quit_smart_app/features/auth/domain/models/app_user.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';
import 'package:quit_smart_app/features/home/home_page.dart';
import 'package:quit_smart_app/features/landing/landing_page.dart';
import 'package:quit_smart_app/features/onboarding/onboarding_page.dart';
import 'package:quit_smart_app/features/quiz/quiz_page.dart';
import 'package:quit_smart_app/features/auth/ui/sing_in_page.dart';

// Define route paths
class AppRoutes {
  static const String landing = '/';
  static const String onboarding = '/onboarding'; 
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String quiz = '/quiz';
}

// Function to create the GoRouter instance
GoRouter createAppRouter(AuthBloc authBloc) {
  print('[AppRouter] createAppRouter called. Initial AuthBloc state: ${authBloc.state}');
  return GoRouter(
    initialLocation: AppRoutes.landing, // Start at landing
    refreshListenable: GoRouterRefreshStream(authBloc),
    navigatorKey: Router.navigatorKey, // Use the static key from Router class
    redirect: (BuildContext context, GoRouterState state) {
      final authState = authBloc.state;
      final user = authState.user;
      final currentLocation = state.matchedLocation;
      print('[AppRouter Redirect] CurrentLocation: $currentLocation, AuthState User: ${user.runtimeType}, AuthBloc Raw State: $authState');

      final isAuthLoading = user is UnknownUser;
      print('[AppRouter Redirect] isAuthLoading: $isAuthLoading');

      if (isAuthLoading) {
        if (currentLocation == AppRoutes.landing) {
          print('[AppRouter Redirect] AuthLoading & OnLanding: Staying on Landing (return null)');
          return null; // Stay on landing if loading
        }
        print('[AppRouter Redirect] AuthLoading & NOT OnLanding: Staying on current page (return null)');
        return null; 
      }

      final isAuthenticated = user is AuthenticatedUser;
      print('[AppRouter Redirect] isAuthenticated: $isAuthenticated');

      final authRequiredRoutes = [AppRoutes.home]; 
      final publicOnlyRoutes = [AppRoutes.onboarding, AppRoutes.signIn];

      if (currentLocation == AppRoutes.landing) {
        final path = isAuthenticated ? AppRoutes.home : AppRoutes.onboarding;
        print('[AppRouter Redirect] OnLanding & AuthDetermined: Redirecting to $path');
        return path;
      }

      if (isAuthenticated && publicOnlyRoutes.contains(currentLocation)) {
        print('[AppRouter Redirect] Authenticated & OnPublicOnlyRoute: Redirecting to ${AppRoutes.home}');
        return AppRoutes.home;
      }

      if (!isAuthenticated && authRequiredRoutes.contains(currentLocation)) {
        print('[AppRouter Redirect] Unauthenticated & OnAuthRequiredRoute: Redirecting to ${AppRoutes.onboarding}');
        return AppRoutes.onboarding;
      }
      print('[AppRouter Redirect] No redirect condition met. Staying on $currentLocation (return null)');
      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
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
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(AuthBloc authBloc) {
    print('[GoRouterRefreshStream] Created. Subscribing to AuthBloc stream.');
    _subscription = authBloc.stream.asBroadcastStream().listen(
      (dynamic authState) {
        print('[GoRouterRefreshStream] Received AuthBloc state: ${authState.runtimeType}, User: ${authState.user.runtimeType}');
        print('[GoRouterRefreshStream] Calling notifyListeners().');
        notifyListeners(); // Notify GoRouter to re-evaluate redirects on new BLoC states
      },
      onError: (error) {
        print('[GoRouterRefreshStream] Error in AuthBloc stream: $error');
      },
      onDone: () {
        print('[GoRouterRefreshStream] AuthBloc stream done.');
      }
    );
  }

  @override
  void dispose() {
    print('[GoRouterRefreshStream] Disposing. Cancelling subscription.');
    _subscription.cancel();
    super.dispose();
  }
}

// Static key for navigator access
class Router { 
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
