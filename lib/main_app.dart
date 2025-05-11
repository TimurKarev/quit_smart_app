import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/auth/domain/repository/auth_repository.dart';
import 'package:quit_smart_app/ui/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quit_smart_app/generated/l10n/app_localizations.dart';
import 'package:quit_smart_app/routing/app_router.dart';
import 'package:quit_smart_app/utils/di/app_di.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppDi({}),
      child: BlocProvider(
        lazy: false,
        create:
            (context) => AuthBloc(
              authRepository: context.read<AppDi>().get<AuthRepository>(),
            )..add(const AuthSubscriptionRequested()),
        child: Builder(
          builder: (context) {
            final authBloc = context.watch<AuthBloc>();
            return MaterialApp.router(
              routerConfig: createAppRouter(authBloc),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', ''), Locale('ru', '')],
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
