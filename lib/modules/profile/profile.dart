import 'package:flutter/material.dart';
import 'package:yd8/core/ui/navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/profile',
    );
  }
}
