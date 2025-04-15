import 'package:flutter/material.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final SettingsLoaded state;
  final Function(Locale) onLocaleChanged;
  final Function(SettingsEvent) onUpdate;

  const LanguageSelector({
    super.key,
    required this.state,
    required this.onLocaleChanged,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(locale.language),
      trailing: ToggleButtons(
        isSelected: [state.language == 'en-US', state.language == 'ar-SA'],
        onPressed: (int index) {
          String selectedLocale;
          switch (index) {
            case 0:
              selectedLocale = 'en-US';
              onLocaleChanged(Locale('en', 'US'));
              break;
            case 1:
            default:
              selectedLocale = 'ar-SA';
              onLocaleChanged(Locale('ar', 'SA'));
              break;
          }
          onUpdate(UpdateLanguage(languageCode: selectedLocale));
        },
        borderRadius: BorderRadius.circular(8.0),
        constraints: const BoxConstraints(minHeight: 40.0),
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('English'), // Display name
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('العربية'), // Display name
          ),
        ],
      ),
    );
  }
}
