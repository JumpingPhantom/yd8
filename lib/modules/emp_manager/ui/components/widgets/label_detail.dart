import 'package:flutter/material.dart';

class LabelDetail extends StatelessWidget {
  final String label;
  final String detail;

  const LabelDetail({super.key, required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      spacing: 8.0,
      children: [
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            detail,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
