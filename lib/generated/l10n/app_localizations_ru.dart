// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'QuitSmart';

  @override
  String get onboardingAppBarTitle => 'QuitSmart';

  @override
  String get onboardingAppBarActionAbout => 'О нас';

  @override
  String get onboardingAppBarActionContact => 'Контакты';

  @override
  String get onboardingWelcomeTitle => 'Начните свой путь к жизни без курения';

  @override
  String get onboardingWelcomeDescription =>
      'QuitSmart помогает вам бросить курить с помощью персонализированных планов, ежедневного отслеживания и поддерживающего сообщества.';

  @override
  String get onboardingInfoCard1Title => 'Оценка';

  @override
  String get onboardingInfoCard1Description =>
      'Пройдите наш тест для определения стадии ваших привычек курения';

  @override
  String get onboardingInfoCard2Title => 'Отслеживайте прогресс';

  @override
  String get onboardingInfoCard2Description =>
      'Следите за своим путем с помощью инструментов ежедневного отслеживания';

  @override
  String get onboardingInfoCard3Title => 'Получите поддержку';

  @override
  String get onboardingInfoCard3Description =>
      'Общайтесь с другими на том же пути';

  @override
  String get onboardingButtonStartTest => 'Начать тест стадии';

  @override
  String get onboardingButtonLearnMore => 'Узнать больше';

  @override
  String get onboardingButtonSignInRegister => 'Войти / Зарегистрироваться';

  @override
  String get footerCopyright => '© 2025 QuitSmart. Все права защищены.';
}
