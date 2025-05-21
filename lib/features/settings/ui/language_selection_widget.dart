import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/settings/ui/bloc/user_settings_bloc.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarTheme = AppBarTheme.of(context);
    final iconColor = appBarTheme.iconTheme?.color ?? Theme.of(context).colorScheme.onPrimary;
    final textColor = appBarTheme.toolbarTextStyle?.color ?? Theme.of(context).colorScheme.onPrimary;
    final dropdownBackgroundColor = appBarTheme.backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor;

    return BlocBuilder<UserSettingsBloc, UserSettingsState>(
      builder: (context, state) {
        final supportedLanguages = {'en': 'EN', 'ru': 'RU'};

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: state.lang,
            icon: Icon(Icons.language, color: iconColor),
            dropdownColor: dropdownBackgroundColor,
            items: supportedLanguages.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: TextStyle(color: textColor),
                ),
              );
            }).toList(),
            onChanged: (String? newLang) {
              if (newLang != null && newLang != state.lang) {
                context.read<UserSettingsBloc>().add(ChangeLanguage(newLang));
              }
            },
            selectedItemBuilder: (BuildContext context) {
              return supportedLanguages.entries.map((entry) {
                return Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    supportedLanguages[state.lang] ?? state.lang.toUpperCase(),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500, // typical for AppBar text
                    ),
                  ),
                );
              }).toList();
            },
          ),
        );
      },
    );
  }
}
