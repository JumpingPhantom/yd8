import 'package:flutter/material.dart';
import 'package:yd8/core/navigation/nav.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Dashboard",
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/',
    );
  }
}
