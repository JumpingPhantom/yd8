import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/types.dart';

class FilterDialog extends StatefulWidget {
  final Set<EmpStatus> initialSelectedStatus;
  final Function(Set<EmpStatus>) onApply;
  final Function() onClear;

  const FilterDialog({
    super.key,
    required this.initialSelectedStatus,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late Set<EmpStatus> _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = Set<EmpStatus>.from(widget.initialSelectedStatus);
  }

  void _handleSelection(EmpStatus status, bool selected) {
    setState(() {
      if (selected) {
        _selectedStatus.add(status);
      } else {
        _selectedStatus.remove(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            locale.filters,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: Text(locale.active),
                  selected: _selectedStatus.contains(EmpStatus.active),
                  onSelected:
                      (bool selected) =>
                          _handleSelection(EmpStatus.active, selected),
                ),
                FilterChip(
                  label: Text(locale.inactive),
                  selected: _selectedStatus.contains(EmpStatus.inactive),
                  onSelected:
                      (bool selected) =>
                          _handleSelection(EmpStatus.inactive, selected),
                ),
                FilterChip(
                  label: Text(locale.terminated),
                  selected: _selectedStatus.contains(EmpStatus.terminated),
                  onSelected:
                      (bool selected) =>
                          _handleSelection(EmpStatus.terminated, selected),
                ),
                FilterChip(
                  label: Text(locale.suspended),
                  selected: _selectedStatus.contains(EmpStatus.suspended),
                  onSelected:
                      (bool selected) =>
                          _handleSelection(EmpStatus.suspended, selected),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ).copyWith(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  widget.onClear();
                  Navigator.pop(context, <EmpStatus>{});
                },
                child: Text(locale.clear),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  widget.onApply(_selectedStatus);
                  Navigator.pop(context, _selectedStatus);
                },
                child: Text(locale.apply),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
