import 'package:flutter/material.dart';
import 'package:yd8/core/navigation/nav.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/settings',
    );
  }
}
