import 'package:flutter/material.dart';
import 'package:yd8/modules/dashboard/ui/dashboard.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/ui/emp_manager.dart';
import 'package:yd8/modules/profile/ui/profile.dart';
import 'package:yd8/modules/reports/ui/reports.dart';
import 'package:yd8/modules/settings/ui/settings.dart';
import 'package:yd8/modules/stats/ui/stats.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardPage(),
        '/emp_manager': (context) => EmpManagerPage(),
        '/profile': (context) => ProfilePage(),
        '/reports': (context) => ReportsPage(),
        '/settings': (context) => SettingsPage(),
        '/stats': (context) => StatsPage(),
      },
    );
  }
}
