import 'package:flutter/material.dart';
import '../../../core/navigation/nav.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Statistics',
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/stats',
    );
  }
}
