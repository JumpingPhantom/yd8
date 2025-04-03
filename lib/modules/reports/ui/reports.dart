import 'package:flutter/material.dart';
import 'package:yd8/core/navigation/nav.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Reports',
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/reports',
    );
  }
}
