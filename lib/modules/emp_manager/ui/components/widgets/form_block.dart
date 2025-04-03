import 'package:flutter/material.dart';

class FormBlock extends StatelessWidget {
  final List<Widget> fields;
  final String title;
  final double? width;

  const FormBlock({
    super.key,
    this.width = 800,
    required this.title,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.headlineSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(spacing: 10, children: fields),
          ),
        ],
      ),
    );
  }
}
