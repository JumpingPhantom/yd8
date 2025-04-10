import 'package:flutter/material.dart';
import '../../../../../core/common/types.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/types.dart';

class GenderRadioGroup extends StatefulWidget {
  final Function(Gender?) onChanged;

  const GenderRadioGroup({super.key, required this.onChanged});

  @override
  State<GenderRadioGroup> createState() => _GenderRadioGroupState();
}

class _GenderRadioGroupState extends State<GenderRadioGroup> {
  Gender? _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            locale.gender,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<Gender>(
          title: Text(locale.male),
          value: Gender.male,
          groupValue: _selectedGender,
          onChanged: (Gender? value) {
            setState(() {
              _selectedGender = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<Gender>(
          title: Text(locale.female),
          value: Gender.female,
          groupValue: _selectedGender,
          onChanged: (Gender? value) {
            setState(() {
              _selectedGender = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<Gender>(
          title: Text(locale.other),
          value: Gender.other,
          groupValue: _selectedGender,
          onChanged: (Gender? value) {
            setState(() {
              _selectedGender = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}

class EmploymentTypeRadioGroup extends StatefulWidget {
  final Function(EmploymentType?) onChanged;

  const EmploymentTypeRadioGroup({super.key, required this.onChanged});

  @override
  State<EmploymentTypeRadioGroup> createState() =>
      _EmploymentTypeRadioGroupState();
}

class _EmploymentTypeRadioGroupState extends State<EmploymentTypeRadioGroup> {
  EmploymentType? _selectedType = EmploymentType.fullTime;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            locale.type,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<EmploymentType>(
          title: Text(locale.full_time),
          value: EmploymentType.fullTime,
          groupValue: _selectedType,
          onChanged: (EmploymentType? value) {
            setState(() {
              _selectedType = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<EmploymentType>(
          title: Text(locale.part_time),
          value: EmploymentType.partTime,
          groupValue: _selectedType,
          onChanged: (EmploymentType? value) {
            setState(() {
              _selectedType = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}

class StatusRadioGroup extends StatefulWidget {
  final Function(EmpStatus?) onChanged;

  const StatusRadioGroup({super.key, required this.onChanged});

  @override
  State<StatusRadioGroup> createState() => _StatusRadioGroupState();
}

class _StatusRadioGroupState extends State<StatusRadioGroup> {
  EmpStatus? _selectedStatus = EmpStatus.active;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            locale.status,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<EmpStatus>(
          title: Text(locale.active),
          value: EmpStatus.active,
          groupValue: _selectedStatus,
          onChanged: (EmpStatus? value) {
            setState(() {
              _selectedStatus = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<EmpStatus>(
          title: Text(locale.inactive),
          value: EmpStatus.inactive,
          groupValue: _selectedStatus,
          onChanged: (EmpStatus? value) {
            setState(() {
              _selectedStatus = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<EmpStatus>(
          title: Text(locale.suspended),
          value: EmpStatus.suspended,
          groupValue: _selectedStatus,
          onChanged: (EmpStatus? value) {
            setState(() {
              _selectedStatus = value;
              widget.onChanged(value);
            });
          },
        ),
        RadioListTile<EmpStatus>(
          title: Text(locale.terminated),
          value: EmpStatus.terminated,
          groupValue: _selectedStatus,
          onChanged: (EmpStatus? value) {
            setState(() {
              _selectedStatus = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}
