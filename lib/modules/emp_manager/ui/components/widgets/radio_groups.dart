import 'package:flutter/material.dart';
import 'package:yd8/core/common/types.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Gender',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<Gender>(
          title: const Text('Male'),
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
          title: const Text('Female'),
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
          title: const Text('Other'),
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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Type',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<EmploymentType>(
          title: const Text('Full-time'),
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
          title: const Text('Part-time'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Status',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<EmpStatus>(
          title: const Text('Active'),
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
          title: const Text('Inactive'),
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
          title: const Text('Suspended'),
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
          title: const Text('Terminated'),
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
