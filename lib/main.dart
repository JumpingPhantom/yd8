import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yd8/modules/dashboard/ui/dashboard.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/ui/emp_manager.dart';
import 'package:yd8/modules/profile/ui/profile.dart';
import 'package:yd8/modules/reports/ui/reports.dart';
import 'package:yd8/modules/settings/ui/settings.dart';
import 'package:yd8/modules/stats/ui/stats.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  initEmpManagerDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yd8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      locale: Locale('en', 'US'),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/emp_manager': (context) => const EmpManagerPage(),
        '/profile': (context) => const ProfilePage(),
        '/reports': (context) => const ReportsPage(),
        '/settings': (context) => const SettingsPage(),
        '/stats': (context) => const StatsPage(),
      },
    );
  }
}
