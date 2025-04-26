import 'package:flutter/material.dart';
import 'package:quit_smart_app/firebase_options.dart';
import 'package:quit_smart_app/main_app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform, // Or your specific options
    );
    debugPrint('Firebase initialized successfully.'); // <-- Add this log
  } catch (e) {
    debugPrint(
      'Firebase initialization failed: $e',
    ); // <-- Check for errors here
  }

  runApp(const MainApp());
}
