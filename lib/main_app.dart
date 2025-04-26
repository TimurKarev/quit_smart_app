import 'package:flutter/material.dart';
// import 'package:quit_smart_app/features/onboarding/onboarding_page.dart'; 
import 'package:quit_smart_app/ui/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:quit_smart_app/generated/l10n/app_localizations.dart';
import 'package:quit_smart_app/routing/app_router.dart'; 

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,

      localizationsDelegates: const [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), 
        Locale('ru', ''), 
      ],
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
