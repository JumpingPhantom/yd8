import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/common/util.dart';
import 'modules/dashboard/ui/dashboard.dart';
import 'modules/emp_manager/di/emp_manager_di.dart';
import 'modules/emp_manager/ui/emp_manager.dart';
import 'modules/profile/ui/profile.dart';
import 'modules/reports/ui/reports.dart';
import 'modules/settings/di/settings_di.dart';
import 'modules/settings/ui/settings.dart';
import 'modules/stats/ui/stats.dart';

Future<void> main() async {
  initEmpManagerDependencies();
  initSettingsDependencies();
  String config = await loadSettings();
  runApp(MyApp(config));
}

class MyApp extends StatefulWidget {
  final String config;

  const MyApp(this.config, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  ThemeMode? themeMode;

  onLocaleChanged(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  onThemeModeChanged(ThemeMode themeMode) {
    setState(() {
      this.themeMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();
    final config = jsonDecode(widget.config);
    locale = stringToLocale(config['language'] as String);
    themeMode = stringToThemeMode(config['appTheme'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yd8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      locale: locale,
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/emp_manager': (context) => const EmpManagerPage(),
        '/profile': (context) => const ProfilePage(),
        '/reports': (context) => const ReportsPage(),
        '/settings':
            (context) => SettingsPage(
              onLocaleChanged: onLocaleChanged,
              onThemeModeChanged: onThemeModeChanged,
            ),
        '/stats': (context) => const StatsPage(),
      },
    );
  }
}
