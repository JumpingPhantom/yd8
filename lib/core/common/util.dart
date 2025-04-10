import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Loads settings from a JSON file.
///
/// Retrieves the application support directory, reads the 'settings.json' file,
/// and returns its content as a string. If the file does not exist, it creates
/// the file with default settings: `{"appTheme": "system", "language": "en-US"}`.
///
/// Returns:
///   A [Future] that resolves to a [String] containing the settings data.
Future<String> loadSettings() async {
  Directory dir = await getApplicationSupportDirectory();

  File file = File('${dir.path}/settings.json');

  if (!await file.exists()) {
    final defaultSettings = '{"appTheme": "system", "language": "en-US"}';
    await file.create();
    await file.writeAsString(defaultSettings);
    return defaultSettings;
  }

  String settings = await file.readAsString();
  return settings;
}

/// Converts a "language-country" string (e.g., "en-US") into a [Locale].
///
/// Handles cases where only the language code is provided (e.g., "en").
/// Returns a default Locale (e.g., 'en') if the format is invalid or empty.
Locale stringToLocale(String langCountry) {
  if (langCountry.isEmpty) {
    print(
      'Warning: Empty langCountry string provided. Using default locale "en".',
    );
    return const Locale('en');
  }

  if (langCountry.contains('-')) {
    final parts = langCountry.split('-');
    // Check for a valid split like "en-US"
    if (parts.length == 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return Locale(parts[0], parts[1]);
    } else {
      // Handle invalid formats like "en-", "-US", "en-US-extra"
      print(
        'Warning: Invalid langCountry format "$langCountry". Attempting to use first part or default "en".',
      );
      // Use the first part if it's not empty, otherwise default to 'en'
      return Locale(parts[0].isNotEmpty ? parts[0] : 'en');
    }
  } else {
    // Assume the whole string is the language code if no hyphen
    return Locale(langCountry);
  }
}

/// Converts a theme string ("light", "dark", "system") into a [ThemeMode].
///
/// Defaults to [ThemeMode.system] if the input string is unrecognized or empty.
ThemeMode stringToThemeMode(String themeString) {
  switch (themeString.toLowerCase()) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'system':
      return ThemeMode.system;
    default:
      if (themeString.isNotEmpty) {
        print(
          'Warning: Unrecognized theme string "$themeString". Defaulting to system.',
        );
      } else {
        print('Warning: Empty theme string provided. Defaulting to system.');
      }
      return ThemeMode.system;
  }
}
