import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'QuitSmart'**
  String get appName;

  /// No description provided for @onboardingAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'QuitSmart'**
  String get onboardingAppBarTitle;

  /// No description provided for @onboardingAppBarActionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get onboardingAppBarActionAbout;

  /// No description provided for @onboardingAppBarActionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get onboardingAppBarActionContact;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Start Your Smoke-Free Journey'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'QuitSmart helps you quit smoking through personalized plans, daily tracking, and supportive community.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @onboardingInfoCard1Title.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get onboardingInfoCard1Title;

  /// No description provided for @onboardingInfoCard1Description.
  ///
  /// In en, this message translates to:
  /// **'Take our stage test to determine your smoking habits'**
  String get onboardingInfoCard1Description;

  /// No description provided for @onboardingInfoCard2Title.
  ///
  /// In en, this message translates to:
  /// **'Track Progress'**
  String get onboardingInfoCard2Title;

  /// No description provided for @onboardingInfoCard2Description.
  ///
  /// In en, this message translates to:
  /// **'Monitor your journey with daily tracking tools'**
  String get onboardingInfoCard2Description;

  /// No description provided for @onboardingInfoCard3Title.
  ///
  /// In en, this message translates to:
  /// **'Get Support'**
  String get onboardingInfoCard3Title;

  /// No description provided for @onboardingInfoCard3Description.
  ///
  /// In en, this message translates to:
  /// **'Connect with others on the same journey'**
  String get onboardingInfoCard3Description;

  /// No description provided for @onboardingButtonStartTest.
  ///
  /// In en, this message translates to:
  /// **'Start Stage Test'**
  String get onboardingButtonStartTest;

  /// No description provided for @onboardingButtonLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get onboardingButtonLearnMore;

  /// No description provided for @onboardingButtonSignInRegister.
  ///
  /// In en, this message translates to:
  /// **'Sign In / Register'**
  String get onboardingButtonSignInRegister;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **' 2025 QuitSmart. All rights reserved.'**
  String get footerCopyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
