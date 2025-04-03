import 'package:flutter/material.dart';
import 'package:yd8/core/navigation/nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile',
      body: Builder(builder: (context) => Placeholder()),
      currentRoute: '/profile',
    );
  }
}
