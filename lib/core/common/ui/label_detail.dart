import 'package:flutter/material.dart';

class LabelDetail extends StatelessWidget {
  final String label;
  final String detail;

  const LabelDetail({super.key, required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.apply(fontWeightDelta: 400),
        ),
        Text(detail, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
