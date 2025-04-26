import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quit_smart_app/ui/theme/app_theme.dart';
import 'package:quit_smart_app/ui/ui_kit/uikit.dart';
import 'package:quit_smart_app/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:quit_smart_app/routing/app_router.dart'; // Import AppRoutes

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboardingAppBarTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(l10n.onboardingAppBarActionAbout, style: AppTheme.appBarActionTextStyle),
                const SizedBox(width: 24),
                Text(l10n.onboardingAppBarActionContact, style: AppTheme.appBarActionTextStyle),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 960,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          l10n.onboardingWelcomeTitle,
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.onboardingWelcomeDescription,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Wrap(
                          spacing: 16.0,
                          runSpacing: 16.0,
                          alignment: WrapAlignment.center,
                          children: [
                            InfoCard(
                              icon: FontAwesomeIcons.clipboardList,
                              title: l10n.onboardingInfoCard1Title,
                              description: l10n.onboardingInfoCard1Description,
                              width: 200,
                              height: 200,
                            ),
                            InfoCard(
                              icon: FontAwesomeIcons.chartLine,
                              title: l10n.onboardingInfoCard2Title,
                              description: l10n.onboardingInfoCard2Description,
                              width: 200,
                              height: 200,
                            ),
                            InfoCard(
                              icon: FontAwesomeIcons.users,
                              title: l10n.onboardingInfoCard3Title,
                              description: l10n.onboardingInfoCard3Description,
                              width: 200,
                              height: 200,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Quiz page
                      context.push(AppRoutes.quiz);
                    },
                    child: Text(l10n.onboardingButtonStartTest),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Learn More action
                      // Example navigation (if needed):
                      // context.push(AppRoutes.learnMore); // Assuming a learn more route exists
                    },
                    child: Text(l10n.onboardingButtonLearnMore),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Sign In / Register action
                      // Example navigation (if needed):
                      // context.push(AppRoutes.signIn); // Assuming a sign in route exists
                    },
                    child: Text(l10n.onboardingButtonSignInRegister),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          color: bottomAppBarTheme.color,
        ),
        child: Center(
          child: Text(
            l10n.footerCopyright,
            style: AppTheme.footerTextStyle,
          ),
        ),
      ),
    );
  }
}
