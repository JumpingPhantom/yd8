import 'package:flutter/material.dart';
import 'package:yd8/core/ui/navigation.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/reports',
    );
  }
}
