import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/types.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';

class ThemeSelector extends StatelessWidget {
  final SettingsLoaded state;
  final Function(ThemeMode) onThemeModeChanged;
  final Function(SettingsEvent) onUpdate;

  const ThemeSelector({
    super.key,
    required this.state,
    required this.onThemeModeChanged,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(locale.theme),
      trailing: ToggleButtons(
        isSelected: [
          state.appTheme == AppTheme.light,
          state.appTheme == AppTheme.dark,
          state.appTheme == AppTheme.system,
        ],
        onPressed: (int index) {
          AppTheme selectedTheme;
          switch (index) {
            case 0:
              selectedTheme = AppTheme.light;
              onThemeModeChanged(ThemeMode.light);
              break;
            case 1:
              selectedTheme = AppTheme.dark;
              onThemeModeChanged(ThemeMode.dark);
              break;
            case 2:
            default:
              selectedTheme = AppTheme.system;
              onThemeModeChanged(ThemeMode.system);
              break;
          }
          // bloc.add(UpdateTheme(appTheme: selectedTheme));
          onUpdate(UpdateTheme(appTheme: selectedTheme));
        },
        borderRadius: BorderRadius.circular(8.0),
        constraints: const BoxConstraints(minHeight: 40.0),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.light_mode, size: 18),
                SizedBox(width: 4),
                Text(locale.light),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.dark_mode, size: 18),
                SizedBox(width: 4),
                Text(locale.dark),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.settings_system_daydream_outlined, size: 18),
                SizedBox(width: 4),
                Text(locale.system),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
