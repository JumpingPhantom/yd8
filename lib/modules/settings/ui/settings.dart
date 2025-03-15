import 'package:flutter/material.dart';
import 'package:yd8/core/ui/navigation.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/settings',
    );
  }
}
