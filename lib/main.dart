import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/auth/domain/repository/auth_repository.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';
import 'package:quit_smart_app/firebase_options.dart';
import 'package:quit_smart_app/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quit_smart_app/utils/di/app_di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform, 
    );
    debugPrint('Firebase initialized successfully.');
  } catch (e) {
    debugPrint(
      'Firebase initialization failed: $e',
    );
  }

  final appDi = AppDi({}); // Initialize AppDi

  runApp(
    RepositoryProvider.value(
      value: appDi, // Provide AppDi instance
      child: BlocProvider<AuthBloc>(
        lazy: false,
        create: (context) => AuthBloc(
          // Read AppDi from the RepositoryProvider.value above
          authRepository: context.read<AppDi>().get<AuthRepository>(),
        )..add(const AuthSubscriptionRequested()),
        child: const MainApp(), // MainApp can now access AuthBloc via context.read in initState
      ),
    ),
  );
}
