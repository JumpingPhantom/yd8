import 'package:flutter/material.dart';

class EmpManagerItem extends StatelessWidget {
  const EmpManagerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(),
        title: Text("Lorem"),
        subtitle: Text("Ipsum"),
      ),
    );
  }
}
